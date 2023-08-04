# Comando terraform

## terraform init 
    Serve para baixar as dependencias do terraform

## terraform fmt
    Serve para formatar os arquivos do terraform, seguindo as boas praticas da Hascode. Esse comando pode ser utilizado o nome do arquivo ou o parametro recursive que irá atualizar todos os arquivos terraform da pasta.

    #### Exemplo 1 :
        terraform fmt ./exemplo-1/main.tf
    #### Exemplo 2 :
        terraform fmt --recursive

## terraform validate
    Serve para validar se os arquivos terraform está configurado da forma correta.

## terraform plan
    Serve para realizar o planajemnto, nele é feito a validação do código e mostra o terraform que será implementado e quais suas alterações

## terraform apply
    Serve para realizar implementar os recursos e suas alterações, por padrão é necessario a aprovação

# Configurações terraform

## required_version
    Serve para travar a versão do terraform.

    ### Exemplo 1
        
        terraform {
            required_version = "1.5.3" # -> O terraform só poderá ser executado no terraform 1.5.3 
        }

    ### Exemplo 2
        
        terraform {
            required_version = ">= 1.5.3" # -> O terraform poderá ser executado em qualquer terraform igual ou acima do 1.5.3
        }

    ### Exemplo 2
        
        terraform {
            required_version = "~> 1.5.3" # -> O terraform poderá ser executado em qualquer terraform igual ou acima do 1.5.3 e abaixo da versão 1.6
        }


## required providers
    Serve para travar a versão do provider que são utilizadas nesse módulo.

    ### Exemplo 1
        
        terraform {
            required_providers {
                aws = {
                    source = "hashicorp/aws" #-> Onde deve ser pesquisado esse provider
                    version = "5.0"  #-> O terraform só pode ser utilizado no provider 5.0
                }
            }
        }

    ### Exemplo 2
        
        terraform {
            required_providers {
                aws = {
                    source = "hashicorp/aws" #-> Onde deve ser pesquisado esse provider
                    version = ">= 5.0"  #-> O terraform só pode ser utilizado em qualquer igual ou acima do 5.0
                }
            }
        }

    ### Exemplo 2
        
        terraform {
            required_providers {
                aws = {
                    source = "hashicorp/aws" #-> Onde deve ser pesquisado esse provider
                    version = "~> 5.0"  #-> O terraform só pode ser utilizado em qualquer igual ou acima do 5.0 e abaixo do 6
                }
            }
        }

# Código terraform

 