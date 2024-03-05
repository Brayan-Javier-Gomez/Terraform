# Instalacion de terraform y CLI de AWS

Para la instalación de terraform podemos basarnos en el siguiente enlace de la documentación:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Para el caso de Windows, es necesario instalar el gestor de paquetes chocolatey siguiendo las instrucciones a continuación: https://docs.chocolatey.org/en-us/choco/setup

Windows cmd: 

`@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"`

Una vez instalado el gestor continuamos con terraform

`choco install terraform`

Si requerimos instalar la CLI de AWS podemos hacerlo desde aqui:
https://aws.amazon.com/es/cli/


# Comandos y conceptos basicos de terraform usando el proveedor AWS

Documentación registry de terraform: https://registry.terraform.io/

Para iniciar la configuración creamos un archivo main.tf

`// configuracion del proveedor de cloud`
`provider "aws" {`
	`// region de proveedor configurado en el cloud`
    `region = "us-east-1"`
`}`

`//Configuracion de instancias el instance 1 es solo una referencia interna, no es el nombre en AWS`
`resource "aws_instance" "instance1" {`
`//codigo ami en catalogo de ami aws`
    `ami ="ami-#######"`
    `instance_type = "t3.micro"`
    `tags = {`
      `"Name" = "first_instance"`
    `}`
`}`

Luego de la configuración básica de la instancia en la terminal inicializamos la configuración de terraform donde se instalaran los plugins necesarios para su funcionamiento.

`terraform init`

Una vez finalice mostrara el siguiente mensaje *"Terraform has been successfully initialized!"*

Si necesitamos validar la sintaxis del fichero main.tf ejecutamos el siguiente comando

`terraform validate`

si es correcto, obtendremos lo siguiente *"Success! The configuration is valid."*

Usaremos el comando a continuación para validar toda la configuración y ejecutar una simulación del funcionamiento de terraform, además podremos validar si las credenciales de aws están correctamente configuradas.

`terraform plan`

es momento de desplegar nuestra infraestructura, con el siguiente comando enviaras las instrucciones a aws para empezar la instancia con el nombre indicado en la configuración.

`terraform apply`

Este generara la misma impresión que el terraform plan, en este caso, solicitara por consola la autorización para enviar las instrucciones a AWS e iniciar la instancia para evitar esta autorizacion manual podemos usar la siguiente bandera

`terraform apply -auto-approve`

obtendremos la siguiente salida de la consola

`aws_instance.instance1: Creating...`
`aws_instance.instance1: Still creating... [10s elapsed]`
`aws_instance.instance1: Creation complete after 14s [id=i-0ff3e9afa63b29d17]`

`Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`

Si es el caso, revisaremos la cli de aws para verificar que la instancia se creo correctamente.

Para revisar la informacion del despliegue podemos usar el siguiente comando

`terraform show`

Podremos ver toda la configuración de la instancia incluyendo ips y demás información de aws.

Si requerimos detener la instancia y toda la infraestructura usaremos el siguiente comando

`terraform destroy`

Este también solicitara autorización para terminarse de ejecutar. Una vez finalize deberia mostrar lo siguiente *"Destroy complete! Resources: 0 destroyed."*

# Uso de variables
Terraform permite el uso de variables como cualquier otro lenguaje de programación, a continuación algunos ejemplos.

Si requerimos usar variables usaremos la siguiente sintaxis

`variable "flavor" {`
  `type = string`
  `default = "t3.micro"`
`}`

para invocar la variable usaremos *var.flavor*:

`instance_type = var.flavor`

Existe otra forma de indicar el valor de la variable, mantenemos la definición de esta omitiendo el valor default

`variable "flavor" {`
  `type = string`
`}`

para definir el valor, al momento de usar *terraform plan* o terraform apply lo indicaremos así:

`terraform plan -var flavor="t3.small"`

con la bandera *-var* seguido del nombre asignaremos el valor teniendo en cuenta el tipo de variable indicado al momento de la definición.

La forma mas común de usar las variables es crear un archivo aparte llamado por ejemplo *variables.tf* donde declararemos todas las variables que necesitemos, este lo utilizara sin necesidad de importar o realizar configuraciones adicionales.

Por otro lado, si requerimos definir el valor de las variables en un fichero global, podemos crear otro archivo llamado por ejemplo *variables.auto.tfvars*, es importante que siempre finalice en *auto.tfvars*, allí definiremos el valor de la siguiente manera:

`flavor = "t3.medium"`

probando con *terraform plan*, podremos ver que funciona correctamente.

Existen estos tipos de datos en variables:

bool : booleanos
string : cadenas de texto
number: numeros

También existen otros tipos importantes de variables como las siguientes.

Listas o arreglos, estos se definen asi:

`variable "environment" {`
  `type = list(string) #los tipos de dato indicados mas arriba`
  `default = [ "dev","beta","prod" ]`
`}`

al momento de usarlas se usan así:

`"Environment" = var.environment[1]`

Si necesitamos valores que sean clave valor, tenemos los valores de tipo *map* estas se definen de la siguiente manera:

`variable "amis"{`
    `type = map(string)`
    `default = {`
      `"amazon" = "ami-#########"`
      `"ubuntu" = "ami-#########"`
      `"red-hat" = "ami-########"`
    `}`
`}`

Y se invocan así: 

`ami = var.amis.amazon`
