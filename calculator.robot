*** Settings ***
Library     AppiumLibrary

Documentation     Testes básicos na calculadora do Android

Suite Setup     Abrir Calculadora
Suite Teardown     Close Application

*** Variables ***
# Configuração do dispositivo
${REMOTE_URL}          http://localhost:4723/wd/hub
${PLATFORM_NAME}       Android
${PLATFORM_VERSION}    11.0
${DEVICE_NAME}         emulator-5554
${APP_PACKAGE}         com.google.android.calculator
${APP_ACTIVITY}        com.android.calculator2.Calculator
${AUTOMATION_NAME}     appium

# Elementos para operações
${SINAL_IGUAL}     xpath=//*[contains(@text,'=')]
${RESULTADO}     xpath=//*[contains(@resource-id,'id/result')]

# Dados para operações e validações
${DIG_1}     8
${DIG_2}     2
${SOMA}      10
${MULTIP}    16
${SUBTR}     6
${DIVISAO}   4

*** Keywords ***
Abrir Calculadora 
  Open Application  ${REMOTE_URL}   automationName=${AUTOMATION_NAME}
  ...  platformName=${PLATFORM_NAME}  platformVersion=${PLATFORM_VERSION}
  ...  appPackage=${APP_PACKAGE}  appActivity=${APP_ACTIVITY}
    
Realizar as operações
  [Arguments]       ${DIGITO_1}   ${DIGITO_2}   ${OPERACAO}
    Sleep   2
    Click Element   xpath=//*[contains (@text, '${DIGITO_1}')]
    Click Element   xpath=//*[contains (@text, '${OPERACAO}')]
    Click Element   xpath=//*[contains (@text, '${DIGITO_2}')]

Visualizar o resultado
    Click Element   ${SINAL_IGUAL}

Validar o resultado
  [Arguments]       ${resultado_esperado}
    ${resultado}   Get Element Attribute   ${RESULTADO}   text
    Should Be Equal   ${resultado}   ${resultado_esperado}

*** Test Cases ***
Soma: Validar a soma de dois números
    [Tags]    soma

    Log    "Somando os números setados"
    Realizar as operações   ${DIG_1}    ${DIG_2}    +

    Log    "Visualizando o Resultado"
    Visualizar o resultado

    Log    "Validando o Resultado"
    Validar o resultado  ${SOMA}

Multiplicação: Validar a multiplicação de dois números
    [Tags]    multiplicacao

    Log    "Multiplicando os números setados"
    Realizar as operações   ${DIG_1}    ${DIG_2}    ×

    Log    "Visualizando o Resultado"
    Visualizar o resultado

    Log    "Validando o Resultado"
    Validar o resultado  ${MULTIP}

Divisão: Validar a divisão de dois números
    [Tags]    divisao

    Log    "Dividindo os números setados"
    Realizar as operações   ${DIG_1}    ${DIG_2}    ÷

    Log    "Visualizando o Resultado"
    Visualizar o resultado

    Log    "Validando o Resultado"
    Validar o resultado  ${DIVISAO}

Subtração: Validar a subtração de dois números
    [Tags]    subtracao

    Log    "Subtraindo os números setados"
    Realizar as operações   ${DIG_1}    ${DIG_2}    −

    Log    "Visualizando o Resultado"
    Visualizar o resultado

    Log    "Validando o Resultado"
    Validar o resultado  ${SUBTR}