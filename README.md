# 🚀 SISTEMA DE ORQUESTACIÓN Y AUTOMATIZACIÓN: PROYECTO MAMAYATECH v1.0
> **Infraestructura como Código (IaC) para el Despliegue de Clústeres en Entornos Virtualizados**

![Terraform](https://img.shields.io/badge/Terraform-1.5.x-purple?style=for-the-badge&logo=terraform)
![VirtualBox](https://img.shields.io/badge/VirtualBox-7.0-blue?style=for-the-badge&logo=virtualbox)
![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04_LTS-orange?style=for-the-badge&logo=ubuntu)
![UAGRM](https://img.shields.io/badge/UAGRM-Ingenier%C3%ADa_en_Sistemas-red?style=for-the-badge)

---

## 📑 TABLA DE CONTENIDOS
1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Visión General del Sistema](#2-visión-general-del-sistema)
3. [Arquitectura de Red y Capas](#3-arquitectura-de-red-y-capas)
4. [Requerimientos del Entorno](#4-requerimientos-del-entorno)
5. [Análisis de Componentes de Software](#5-análisis-de-componentes-de-software)
6. [Guía de Instalación y Despliegue](#6-guía-de-instalación-y-despliegue)
7. [Hardening y Protocolos de Seguridad](#7-hardening-y-protocolos-de-seguridad)
8. [Estructura del Repositorio](#8-estructura-del-repositorio)
9. [Gestión de Ciclo de Vida (Lifecycle)](#9-gestión-de-ciclo-de-vida)
10. [Matriz de Resolución de Conflictos (Troubleshooting)](#10-matriz-de-resolución-de-conflictos)
11. [Glosario Técnico Especializado](#11-glosario-técnico-especializado)
12. [Declaración de Autoría](#12-declaración-de-autoría)

---

## 1. RESUMEN EJECUTIVO
El proyecto **MamayaTech** representa una solución avanzada de **DevOps** para la Facultad de Ingeniería en Sistemas (UAGRM). Su propósito principal es la transición de la administración de sistemas tradicional hacia la **Infraestructura como Código (IaC)**. 

Mediante el uso de lenguajes declarativos (HCL), el sistema es capaz de instanciar, configurar y asegurar nodos de cómputo en cuestión de minutos, eliminando el error humano y garantizando la paridad entre entornos de desarrollo y producción.

---

## 2. VISIÓN GENERAL DEL SISTEMA
El núcleo del proyecto utiliza **Terraform** como orquestador principal. A diferencia de los scripts de bash tradicionales, Terraform mantiene un "estado" del mundo real, permitiendo actualizaciones incrementales y destrucción controlada de recursos.

### Objetivos Principales:
* **Automatización del Aprovisionamiento:** Clonación y despliegue de imágenes OVA de Ubuntu.
* **Gestión de Configuración:** Inyección de servicios (Node.js, MySQL) post-creación.
* **Inmutabilidad:** Capacidad de destruir y recrear nodos sin pérdida de configuración lógica.

---

## 3. ARQUITECTURA DE RED Y CAPAS
El despliegue se organiza en un modelo de tres capas lógicas para asegurar la modularidad:

### A. Capa de Hipervisor (VirtualBox)
Se encarga de la gestión de recursos físicos (CPU, RAM, Almacenamiento). Cada nodo (`srv-mamaya-n`) se configura con 1 vCPU y 1GB de RAM para optimizar el consumo en el host.

### B. Capa de Red (Networking)
Se utiliza el modo **Bridged Adapter**. Esto permite que cada VM actúe como un dispositivo independiente en la red de la UAGRM o la red doméstica, obteniendo su propia dirección IP mediante DHCP o asignación estática, facilitando el acceso SSH externo.

### C. Capa de Aplicación
Instalación automatizada de un stack tecnológico moderno:
* **Runtime:** Node.js para servicios back-end.
* **Database:** MySQL Server para persistencia de datos.
* **Proxy/Web:** Preparado para despliegue de aplicaciones Express.

---

## 4. REQUERIMIENTOS DEL ENTORNO

### Estación de Trabajo (Host):
* **Sistema Operativo:** Windows 10/11 Pro/Home.
* **Procesador:** Soporte para virtualización VT-x/AMD-V activado en BIOS.
* **RAM:** Mínimo 8GB (recomendado 16GB).

### Dependencias de Software:
* **Terraform CLI (v1.5.0+):** Debe estar en el PATH de Windows.
* **Oracle VirtualBox (v7.0.x):** Incluyendo el Extension Pack.
* **Git Bash:** Para ejecución de comandos de terminal.

---

## 5. ANÁLISIS DE COMPONENTES DE SOFTWARE

### El Provider (`terra-farm/virtualbox`)
Este plugin actúa como el traductor entre las instrucciones de Terraform y la API de VirtualBox (`VBoxManage`). Permite que el código gestione el ciclo de vida de la VM sin abrir la interfaz gráfica.

### El Provisioner (`remote-exec`)
Es el componente más crítico. Utiliza el protocolo SSH para conectarse a las máquinas una vez que están "vivas". Ejecuta una secuencia de comandos bash para transformar una instalación limpia de Ubuntu en un servidor funcional.

---

## 6. GUÍA DE INSTALACIÓN Y DESPLIEGUE

### Paso 1: Clonación y Preparación
```bash
git clone [https://github.com/guinchalopezjuancarlos/proyecto_automatizacio_vm.git](https://github.com/guinchalopezjuancarlos/proyecto_automatizacio_vm.git)
cd proyecto_automatizacio_vm