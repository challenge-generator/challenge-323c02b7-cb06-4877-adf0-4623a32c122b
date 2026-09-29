# language: es

Feature: Integración de servicios SOA para procesamiento de pagos y notificaciones
  Como arquitecto de integración
  Quiero asegurar que los servicios de cuentas, pagos y notificaciones interactúen correctamente
  Para garantizar consistencia, escalabilidad y resiliencia en la arquitectura SOA

  Background:
    Given El servicio de gestión de cuentas está disponible
    And El servicio de procesamiento de pagos está disponible
    And El servicio de notificaciones está disponible
    And Se ha definido el siguiente contrato OpenAPI para la integración:
      """
      paths:
        /accounts/{accountId}:
          get:
            summary: Obtener detalles de una cuenta
            responses:
              200:
                description: Detalles de la cuenta
                content:
                  application/json:
                    schema:
                      $ref: '#/components/schemas/Account'
              404:
                description: Cuenta no encontrada
      components:
        schemas:
          Account:
            type: object
            properties:
              id:
                type: string
                format: uuid
              balance:
                type: number
                format: double
              status:
                type: string
                enum: [ACTIVE, BLOCKED, CLOSED]
      """

  Scenario: Procesamiento exitoso de un pago desde una cuenta activa
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174000" y balance de 1000.00 y estado ACTIVE
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174000"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Actualizar balance                          | Balance = 500.00                           |
      | Servicio de Pagos          | Registrar transacción                       | Estado = COMPLETED                         |
      | Servicio de Notificaciones  | Enviar notificación al cliente              | Notificación entregada con éxito           |
      | Base de Datos              | Persistir cambios                           | Cambios confirmados                        |

  Scenario: Intento de pago desde una cuenta con fondos insuficientes
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174000" y balance de 200.00 y estado ACTIVE
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174000"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Rechazar transacción                       | Balance permanece en 200.00                |
      | Servicio de Pagos          | Registrar transacción fallida               | Estado = REJECTED, motivo = INSUFFICIENT_FUNDS |
      | Servicio de Notificaciones  | Enviar notificación de rechazo al cliente   | Notificación entregada con éxito           |

  Scenario: Intento de pago desde una cuenta bloqueada
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174001" y balance de 1000.00 y estado BLOCKED
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174001"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Rechazar transacción                       | Estado de la cuenta permanece BLOCKED       |
      | Servicio de Pagos          | Registrar transacción fallida               | Estado = REJECTED, motivo = ACCOUNT_BLOCKED |
      | Servicio de Notificaciones  | Enviar notificación de rechazo al cliente   | Notificación entregada con éxito           |

  Scenario: Fallo en el servicio de notificaciones durante un pago exitoso
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174000" y balance de 1000.00 y estado ACTIVE
    And El servicio de notificaciones está temporalmente no disponible
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174000"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Actualizar balance                          | Balance = 500.00                           |
      | Servicio de Pagos          | Registrar transacción                       | Estado = COMPLETED                         |
      | Servicio de Notificaciones  | Reintentar envío de notificación            | Notificación marcada para reintento        |
      | Sistema de Monitoreo       | Registrar alerta de fallo                   | Alerta generada                            |

  Scenario: Timeout en el servicio de pagos durante el procesamiento
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174000" y balance de 1000.00 y estado ACTIVE
    And El servicio de pagos tarda más de 5 segundos en responder
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174000"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Mantener balance sin cambios                | Balance permanece en 1000.00               |
      | Servicio de Pagos          | Registrar intento fallido                   | Estado = PENDING, motivo = TIMEOUT         |
      | Servicio de Notificaciones  | Enviar notificación de retraso al cliente   | Notificación entregada con éxito           |
      | Sistema de Monitoreo       | Registrar alerta de timeout                 | Alerta generada                            |

  Scenario: Inconsistencia temporal entre servicios durante un pago
    Given Una cuenta con ID "123e4567-e89b-12d3-a456-426614174000" y balance de 1000.00 y estado ACTIVE
    And El servicio de pagos confirma la transacción pero el servicio de cuentas falla al actualizar
    When Se recibe una solicitud de pago por 500.00 desde la cuenta "123e4567-e89b-12d3-a456-426614174000"
    Then El sistema debe:
      | servicio_destino          | acción                                      | resultado_esperado                          |
      | Servicio de Cuentas        | Reintentar actualización                    | Balance finalmente actualizado a 500.00    |
      | Servicio de Pagos          | Mantener estado COMPLETED                   | Transacción confirmada                     |
      | Servicio de Notificaciones  | Enviar notificación al cliente              | Notificación entregada con retraso        |
      | Sistema de Monitoreo       | Registrar inconsistencia                    | Alerta generada                            |