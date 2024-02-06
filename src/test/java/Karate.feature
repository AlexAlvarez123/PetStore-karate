@PetStore
Feature: Ejecucion de pruebas para PetStore

  @InsertarMascota
  Scenario: Insertar un nueva mascota
    Given url 'https://petstore.swagger.io/v2/pet/'
    When def body = read ('classpath:JSON/bodyInsert.json')
    And request body
    And method POST
    Then status 200

  @BusquedaById
  Scenario Outline: busqueda por id
    Given url 'https://petstore.swagger.io/v2/pet/' + <id>
    When method GET
    And match response.id == 100
    And match response.status == 'available'
    Then status 200
    Examples:
      | id  |
      | 100 |

  @ActualizarNombreyStatus
  Scenario Outline: Actualizar nombre y status
    Given url 'https://petstore.swagger.io/v2/pet/'
    When def body = read ('classpath:JSON/bodyUpdate.json')
    And request body
    And method POST
    And match response.name == '<name>'
    And match response.status == '<status>'
    Then status 200
    Examples:
      | name         | status |
      | PerroPeruano | sold   |

  @BusquedaByStatus
  Scenario Outline: busqueda por status
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=' + '<status>'
    When method GET
    And match response[*].id contains <id>
    Then status 200
    Examples:
      | status | id  |
      | sold   | 100 |