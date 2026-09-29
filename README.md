# Diseño y aplicación de patrones de integración en una arquitectura SOA

El equipo de arquitectura de una empresa fintech necesita rediseñar su arquitectura orientada a servicios (SOA) para mejorar la integración y la comunicación entre los diferentes servicios. La arquitectura actual presenta problemas de consistencia y escalabilidad, y se ha decidido aplicar patrones de integración para resolver estos problemas. Los servicios involucrados incluyen el servicio de gestión de cuentas, el servicio de procesamiento de pagos y el servicio de notificación de eventos. El objetivo es diseñar una solución que aplique patrones de integración y principios de API o microservicios para mejorar la arquitectura SOA.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | diseño de la arquitectura SOA |
| **Nivel** | advanced-l3 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Identificación de las necesidades de integración

**Objetivo:** Identificar los puntos de integración necesarios entre los servicios y los patrones de integración adecuados.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Analiza los servicios involucrados y sus interacciones actuales.
- Identifica los puntos de integración necesarios y los patrones de integración adecuados para cada uno.

**Entregable:** Lista de puntos de integración y patrones de integración propuestos.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los diferentes tipos de patrones de integración y sus ventajas y desventajas.
- Evalúa la escalabilidad y la consistencia de la solución propuesta.

</details>

### Fase 2: Diseño de la arquitectura SOA con patrones de integración

**Objetivo:** Diseñar la arquitectura SOA aplicando los patrones de integración identificados en la fase anterior.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Aplica los patrones de integración identificados en la fase anterior para diseñar la arquitectura SOA.
- Considera la escalabilidad, la consistencia y la mantenibilidad de la solución propuesta.

**Entregable:** Diagrama de la arquitectura SOA con los patrones de integración aplicados.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los diferentes tipos de arquitecturas SOA y sus ventajas y desventajas.
- Evalúa la escalabilidad, la consistencia y la mantenibilidad de la solución propuesta.

</details>

### Fase 3: Evaluación y optimización de la arquitectura SOA

**Objetivo:** Evaluar y optimizar la arquitectura SOA diseñada en la fase anterior.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Evalúa la arquitectura SOA diseñada en la fase anterior en términos de escalabilidad, consistencia y mantenibilidad.
- Identifica posibles mejoras y optimizaciones para la arquitectura SOA.

**Entregable:** Informe de evaluación y optimización de la arquitectura SOA.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los diferentes tipos de pruebas y métricas que se pueden utilizar para evaluar la arquitectura SOA.
- Evalúa las posibles mejoras y optimizaciones para la arquitectura SOA en términos de escalabilidad, consistencia y mantenibilidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son los patrones de integración y cómo se aplican en una arquitectura SOA?
- **paraQueSirve**: ¿Para qué sirven los patrones de integración en una arquitectura SOA?
- **comoSeUsa**: ¿Cómo se usan los patrones de integración en una arquitectura SOA?
- **erroresComunes**: ¿Cuáles son los errores comunes al aplicar patrones de integración en una arquitectura SOA?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño de una arquitectura SOA con patrones de integración?

## Criterios de Evaluacion

- Identificación correcta de los puntos de integración y patrones de integración adecuados.
- Diseño de la arquitectura SOA aplicando los patrones de integración identificados.
- Evaluación y optimización efectiva de la arquitectura SOA.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
npx --yes @redocly/cli lint contratos/openapi.yaml
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
