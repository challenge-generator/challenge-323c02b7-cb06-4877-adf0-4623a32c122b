# Flujo de Negocio - Integración SOA

## Descripción
Este documento describe el flujo de negocio para la integración entre los servicios de gestión de cuentas, procesamiento de pagos y notificaciones, utilizando notación BPMN 2.0. Se aplican patrones de integración como orquestación y eventos de mensaje para garantizar consistencia y escalabilidad.

## Diagrama BPMN

```bpmn
<?xml version="1.0" encoding="UTF-8"?>
<bpmn:definitions xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL"
                  xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
                  xmlns:dc="http://www.omg.org/spec/DD/20100524/DC"
                  xmlns:di="http://www.omg.org/spec/DD/20100524/DI"
                  id="Definitions_1"
                  targetNamespace="http://bpmn.io/schema/bpmn">
  <bpmn:process id="Process_1" isExecutable="false">
    <bpmn:startEvent id="StartEvent_1" name="Inicio">
      <bpmn:outgoing>Flow_1</bpmn:outgoing>
    </bpmn:startEvent>
    <bpmn:sequenceFlow id="Flow_1" sourceRef="StartEvent_1" targetRef="Task_1" />
    <bpmn:task id="Task_1" name="Crear Cuenta">
      <bpmn:incoming>Flow_1</bpmn:incoming>
      <bpmn:outgoing>Flow_2</bpmn:outgoing>
    </bpmn:task>
    <bpmn:sequenceFlow id="Flow_2" sourceRef="Task_1" targetRef="Gateway_1" />
    <bpmn:exclusiveGateway id="Gateway_1" name="¿Cuenta creada?">
      <bpmn:incoming>Flow_2</bpmn:incoming>
      <bpmn:outgoing>Flow_3</bpmn:outgoing>
      <bpmn:outgoing>Flow_4</bpmn:outgoing>
    </bpmn:exclusiveGateway>
    <bpmn:sequenceFlow id="Flow_3" sourceRef="Gateway_1" targetRef="Task_2" name="Sí">
      <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression">${cuentaCreada == true}</bpmn:conditionExpression>
    </bpmn:sequenceFlow>
    <bpmn:sequenceFlow id="Flow_4" sourceRef="Gateway_1" targetRef="EndEvent_1" name="No">
      <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression">${cuentaCreada == false}</bpmn:conditionExpression>
    </bpmn:sequenceFlow>
    <bpmn:task id="Task_2" name="Procesar Pago">
      <bpmn:incoming>Flow_3</bpmn:incoming>
      <bpmn:outgoing>Flow_5</bpmn:outgoing>
    </bpmn:task>
    <bpmn:sequenceFlow id="Flow_5" sourceRef="Task_2" targetRef="Gateway_2" />
    <bpmn:exclusiveGateway id="Gateway_2" name="¿Pago exitoso?">
      <bpmn:incoming>Flow_5</bpmn:incoming>
      <bpmn:outgoing>Flow_6</bpmn:outgoing>
      <bpmn:outgoing>Flow_7</bpmn:outgoing>
    </bpmn:exclusiveGateway>
    <bpmn:sequenceFlow id="Flow_6" sourceRef="Gateway_2" targetRef="Task_3" name="Sí">
      <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression">${pagoExitoso == true}</bpmn:conditionExpression>
    </bpmn:sequenceFlow>
    <bpmn:sequenceFlow id="Flow_7" sourceRef="Gateway_2" targetRef="EndEvent_1" name="No">
      <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression">${pagoExitoso == false}</bpmn:conditionExpression>
    </bpmn:sequenceFlow>
    <bpmn:task id="Task_3" name="Enviar Notificación">
      <bpmn:incoming>Flow_6</bpmn:incoming>
      <bpmn:outgoing>Flow_8</bpmn:outgoing>
    </bpmn:task>
    <bpmn:sequenceFlow id="Flow_8" sourceRef="Task_3" targetRef="EndEvent_1" />
    <bpmn:endEvent id="EndEvent_1" name="Fin">
      <bpmn:incoming>Flow_4</bpmn:incoming>
      <bpmn:incoming>Flow_8</bpmn:incoming>
    </bpmn:endEvent>
  </bpmn:process>
  <bpmndi:BPMNDiagram id="BPMNDiagram_1">
    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">
      <bpmndi:BPMNShape id="_BPMNShape_StartEvent_2" bpmnElement="StartEvent_1">
        <dc:Bounds x="100" y="100" width="36" height="36" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="Task_1_di" bpmnElement="Task_1">
        <dc:Bounds x="200" y="100" width="100" height="80" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="Gateway_1_di" bpmnElement="Gateway_1">
        <dc:Bounds x="350" y="100" width="50" height="50" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="Task_2_di" bpmnElement="Task_2">
        <dc:Bounds x="450" y="100" width="100" height="80" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="Gateway_2_di" bpmnElement="Gateway_2">
        <dc:Bounds x="600" y="100" width="50" height="50" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="Task_3_di" bpmnElement="Task_3">
        <dc:Bounds x="700" y="100" width="100" height="80" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNShape id="EndEvent_1_di" bpmnElement="EndEvent_1">
        <dc:Bounds x="850" y="100" width="36" height="36" />
      </bpmndi:BPMNShape>
      <bpmndi:BPMNEdge id="Flow_1_di" bpmnElement="Flow_1">
        <di:waypoint xsi:type="dc:Point" x="136" y="118" />
        <di:waypoint xsi:type="dc:Point" x="200" y="140" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_2_di" bpmnElement="Flow_2">
        <di:waypoint xsi:type="dc:Point" x="300" y="140" />
        <di:waypoint xsi:type="dc:Point" x="350" y="125" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_3_di" bpmnElement="Flow_3">
        <di:waypoint xsi:type="dc:Point" x="375" y="100" />
        <di:waypoint xsi:type="dc:Point" x="450" y="140" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_4_di" bpmnElement="Flow_4">
        <di:waypoint xsi:type="dc:Point" x="375" y="150" />
        <di:waypoint xsi:type="dc:Point" x="850" y="118" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_5_di" bpmnElement="Flow_5">
        <di:waypoint xsi:type="dc:Point" x="550" y="140" />
        <di:waypoint xsi:type="dc:Point" x="600" y="125" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_6_di" bpmnElement="Flow_6">
        <di:waypoint xsi:type="dc:Point" x="625" y="100" />
        <di:waypoint xsi:type="dc:Point" x="700" y="140" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_7_di" bpmnElement="Flow_7">
        <di:waypoint xsi:type="dc:Point" x="625" y="150" />
        <di:waypoint xsi:type="dc:Point" x="850" y="118" />
      </bpmndi:BPMNEdge>
      <bpmndi:BPMNEdge id="Flow_8_di" bpmnElement="Flow_8">
        <di:waypoint xsi:type="dc:Point" x="800" y="140" />
        <di:waypoint xsi:type="dc:Point" x="850" y="118" />
      </bpmndi:BPMNEdge>
    </bpmndi:BPMNPlane>
  </bpmndi:BPMNDiagram>
</bpmn:definitions>
```

## Actores y Servicios
- **Gestión de Cuentas**: Servicio encargado de crear y gestionar cuentas de clientes.
- **Procesamiento de Pagos**: Servicio encargado de procesar pagos entre cuentas.
- **Notificaciones**: Servicio encargado de enviar notificaciones a los clientes.

## Patrones de Integración
- **Orquestación**: El flujo principal es orquestado por un componente central que coordina las llamadas a los servicios.
- **Eventos de Mensaje**: Los servicios emiten eventos para notificar cambios de estado (ej: pago completado).

## Puntos de Decisión
1. **Creación de Cuenta**: ¿La cuenta fue creada exitosamente?
2. **Procesamiento de Pago**: ¿El pago fue procesado exitosamente?

## Transacciones
- La creación de cuenta y el procesamiento de pagos deben ser atómicos para garantizar consistencia.
- Las notificaciones son asíncronas y no bloquean el flujo principal.