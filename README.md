# :money_with_wings: Billinho :mortar_board:

Billinho é um projeto cujo objetivo é a simulação de uma API com microserviços para o gerenciamento de mensalidades e matrículas de alunos às suas respectivas instituições de ensino.

O projeto faz parte do teste técnico aplicado pela [Quero Educação](https://quero.education).

## Dando o pontapé inicial

A seguir, são listadas as dependências para execução do projeto localmente e os passo a passos necessários até o teste da aplicação.

### Requisitos necessários

| Tecnologia    | Versão |
| --- | --- |
| Ruby | >= 2.3 |
| Ruby on Rails | >= 5.1.6  |
| PostgreSQL    | >= 10.5 |
| Postman | |

Caso seja necessário, configure a senha para o banco de dados no seguinte arquivo:
> app/config/database.yml

### Clonando o projeto
```bash
git clone https://github.com/nikolasrangel/billinho_jr.git
cd billinho_jr
```

### Instalando as dependências
```bash
bundle install
```

### Criando e populando as tabelas no banco de dados
```bash
rake db:drop db:create db:migrate db:seed
```

### Iniciando o projeto na porta 3000
```bash
rails s -p 3000
```

### Testando os endpoints da API

Importe ao Postman a coleção presente no seguinte caminho:
```
tests/education-interview.postman_collection
```

## Informações da API
* Todos endpoints retornam um objeto JSON;
* A resposta de cada requisição possui seu código corresponde da tabela de códigos de status de respostas HTTP;
* CORS habilitado;
* Utilização do PostgreSQL como SGBD.

## Descrição do funcionamento da API

### 1. Instituição

A seguir são descritos os endpoints referentes a entidade Instituição.

#### 1.1 Obter todas as instituições

**Descrição:** Retorna todas as instituições contidas no banco de dados.

**Verbo HTTP e URI**:
```
GET /api/v1/institutions
```

**Parâmetro(s):** nenhum.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "All institutions."
    "data": [
        {
            "id": 1,
            "nome": "Nome Instituição 0",
            "cnpj": "0123456789",
            "tipo": "Universidade"
        },
        {
        ...
        }
    ]
}
```

#### 1.2 Obter uma única instituição

**Descrição:** Retorna, caso exista, a instituição que corresponde ao ID passado como parâmetro.

**Verbo HTTP e URI:**
```
GET /api/v1/institutions/:id
```

**Parâmetro(s):** ID da Instituição.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Institution with ID: 1."
    "data": {
        "id": 1,
        "nome": "Nome Instituição 0",
        "cnpj": "0123456789",
        "tipo": "Universidade"
    }
}
```

#### 1.3 Inserir uma nova instituição

**Descrição:** Insere, caso já não exista, a instituição no banco de dados.

**Verbo HTTP e URI:**
```
POST /v1/institutions
```

**Parâmetro(s):** nenhum.

**Detalhes da requisição:**

| Nome do campo | Tipo | Mandatorio | Restrição | Descrição |
| --- | --- | --- | --- | --- |
| nome | texto | Sim | Não pode estar vazio e deve ser único | Descreve o nome da instituição |
| cnpj | texto | Sim | Deve conter apenas caracteres numéricos e deve ser único | Descreve o CNPJ da instituição |
| tipo | texto | Sim | Deve ser: Universidade, Escola ou Creche | Descreve o tipo da instituição |

**Estrutura do body da requisição:**
```javascript
{
    "nome": "Nome Instituição 0",
    "cnpj": "0123456789",
    "tipo": "Universidade"
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Institution saved"
    "data": {
        "id": 1,
        "nome": "Nome Instituição 0",
        "cnpj": "0123456789",
        "tipo": "Universidade"
    }
}
```

### 2. Aluno

A seguir são descritos os endpoints referentes a entidade Aluno.

#### 2.1 Obter todos os alunos

**Descrição:** Retorna todos os alunos contidos no banco de dados.

**Verbo HTTP e URI:**
```
GET /api/v1/students
```

**Parâmetro(s):** nenhum.

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "All students.",
    "data": [
        {
            "id": 1,
            "nome_estudante": "Nome 0",
            "cpf": "0123456789",
            "data_nascimento": "1994-05-20",
            "telefone_celular": 12981818080,
            "genero": "M",
            "tipo_pagamento": "Cartão"
        },
        {
        ...
        }
    ]
}
```

#### 2.2 Obter um único aluno

**Descrição:** Retorna, caso exista, o aluno que corresponde ao ID passado como parâmetro.

**Verbo HTTP e URI:**
```
GET /api/v1/students/:id
```

**Parâmetro(s):** ID do estudante.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Student with ID: 1.",
    "data": {
        "id": 1,
        "nome_estudante": "Nome 0",
        "cpf": "0",
        "data_nascimento": "1994-05-20",
        "telefone_celular": 12981805381,
        "genero": "M",
        "tipo_pagamento": "Cartão"
    }
}
```

#### 2.3 Inserir um novo aluno

**Descrição:** Insere, caso não exista, a instituição no banco de dados.

**Verbo HTTP e URI:**
```
POST /api/v1/students
```

**Parâmetro(s):** nenhum.

**Detalhes da requisição:**

| Nome do campo | Tipo | Mandatorio | Restrição | Descrição |
| --- | --- | --- | --- | --- |
| nome_estudante | texto | Sim | Deve ser único e não pode estar vazio | Descreve o nome do aluno |
| cpf | texto | Sim | Deve conter apenas caracteres numéricos, deve ser único e não pode estar vazio | Descreve o CPF do aluno |
| data_nascimento | texto | Não |  | Descreve a data de nascimento do aluno no formato YYYY-MM-DD |
| telefone_celular | inteiro | Não |  | Descreve o telefone do aluno |
| genero | texto | Sim | Não pode ser vazio e tem que estar entre M ou F | Descreve o gênero do aluno |
| tipo_pagamento | texto | Sim | Não pode ser vazio e tem que estar entre Boleto ou Cartão | Descreve o tipo de pagamento |

**Estrutura do body da requisição:**
```javascript
{
	"nome_estudante": "Nikolas José Rangel de Souza",
	"cpf": "42200000000",
	"data_nascimento": "1994-05-20",
	"telefone_celular": "12981808180",
	"genero": "M",
	"tipo_pagamento": "Cartão"
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Student saved.",
    "data": {
        "id": 11,
        "nome_estudante": "Nikolas José Rangel de Souza",
        "cpf": "42200000000",
        "data_nascimento": "1994-05-20",
        "telefone_celular": 12981808180,
        "genero": "M",
        "tipo_pagamento": "Cartão"
    }
}
```

### 3. Matrícula

A seguir são descritos os endpoints referentes a entidade Matrícula.

#### 3.1 Obter todas as matrículas de um estudante

**Descrição:** Retorna todas as matrículas realizadas para o estudante com o ID passado na requisição.

**Verbo HTTP e URI:**
```
GET /api/v1/students/:student_id/enrollments
```

**Parâmetro(s):** ID do estudante.

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "All enrollments from the student's ID: 1",
    "data": [
        {
            "id": 1,
            "valor_total": "1500.0",
            "qtd_faturas": 4,
            "nome_curso": "Engenharia da Computação",
            "institution_id": 1,
            "student_id": 1
        }
    ]
}
```

#### 3.2 Obtém uma matrícula específica de um aluno em específico

**Descrição:** Utiliza do ID da matrícula e do aluno para trazer, caso exista, aquela matrícula associada ao aluno. 

**Verbo HTTP e URI:**
```
GET /api/v1/students/:student_id/enrollments/:id
```

**Parâmetro(s):** ID da matrícula e do aluno.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Enrollment's ID: 11 from the student's ID: 1",
    "data": [
        {
            "id": 11,
            "valor_total": "1500.0",
            "qtd_faturas": 4,
            "dia_vencimento": 4,
            "nome_curso": "Engenharia da Computação",
            "institution_id": 3,
            "student_id": 1,
            "nome_instituicao": "Universidade 2",
            "nome_estudante": "Nome 0"
        }
    ]
}
```

#### 3.3 Inserir uma nova matrícula para um aluno em específico

**Descrição:** Insere uma nova matrícula para o aluno.

**Verbo HTTP e URI:**
```
POST /api/v1/students/:student_id/enrollments
```

**Parâmetro(s):** ID do estudante que está se matriculando.

**Detalhes da requisição:**

| Nome do campo | Tipo | Mandatorio | Restrição | Descrição |
| ---- | ---- | --- | --- | --- |
| nome_estudante | texto | Sim | Deve ser único e não pode estar vazio | Descreve o nome do aluno |
| cpf | texto | Sim | Deve conter apenas caracteres numéricos, deve ser único e não pode estar vazio | Descreve o CPF do aluno |
| data_nascimento | texto | Não |  | Descreve a data de nascimento do aluno no formato YYYY-MM-DD |
| telefone_celular | inteiro | Não |  | Descreve o telefone do aluno |
| genero | texto | Sim | Não pode ser vazio e tem que estar entre M ou F | Descreve o gênero do aluno |
| tipo_pagamento | texto | Sim | Não pode ser vazio e tem que estar entre Boleto ou Cartão | Descreve o tipo de pagamento |

**Estrutura do body da requisição:**
```javascript
{
	"valor_total": 1500.00,
	"qtd_faturas": 4,
	"dia_vencimento": 4,
	"nome_curso": "Engenharia da Computação",
	"institution_id": 3
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Enrollment saved.",
    "data": {
        "id": 11,
        "valor_total": "1500.0",
        "qtd_faturas": 4,
        "dia_vencimento": 4,
        "nome_curso": "Engenharia da Computação",
        "institution_id": 3,
        "student_id": 1
    }
}
```

### 4. Fatura

A seguir são descritos os endpoints referentes a entidade Faturas.

#### 4.1 Obter todas as faturas para um aluno em específico

**Descrição:** Retorna todas as faturas para o estudante com o ID passado na requisição.

**Verbo HTTP e URI:**
```
GET /api/v1/students/:student_id/bills
```

**Parâmetro(s):** ID do estudante.

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "All bills from the student ID: 6.",
    "data": [
        {
            "id": 21,
            "valor_fatura": "375.0",
            "data_vencimento": "2018-10-20",
            "status": "Aberta",
            "enrollment_id": 6,
            "student_id": 6
        },
        {
            ...
        }
    ]
}
```

#### 4.2 Obtém uma fatura específica de um aluno em específico

**Descrição:** Utiliza do ID da fatura e do aluno para trazer, caso exista, aquela fatura associada ao aluno. 

**Verbo HTTP e URI:**
```
GET /api/v1/students/:student_id/bills/:id
```

**Parâmetro(s):** ID da fatura e do aluno.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Bill's ID: 21 for the student's ID: 6.",
    "data": {
        "id": 21,
        "valor_fatura": "375.0",
        "data_vencimento": "2018-10-20",
        "status": "Aberta",
        "enrollment_id": 6,
        "student_id": 6
    }
}
```

#### 4.3 Atualiza o campo "status" de uma fatura específica de um aluno em específico

**Descrição:** Utiliza do ID da fatura e do aluno para atualizar, caso exista tal fatura e aluno, o campo "status".

**Verbo HTTP e URI:**
```
PATCH /api/v1/students/:student_id/bills/:id
```

**Parâmetro(s):** ID da fatura e do aluno.

**Detalhes da requisição:**

| Nome do campo | Tipo | Mandatorio | Restrição | Descrição |
| ---- | ---- | --- | --- | --- |
| status | texto | Sim | Não pode estar vazio e tem que estar dentro dos valores Aberta, Atrasada ou Paga sendo o valor default Aberta | Descreve o status da fatura |

**Estrutura do body da requisição:**
```javascript
{
	"valor_total": 1500.00,
	"qtd_faturas": 4,
	"dia_vencimento": 4,
	"nome_curso": "Engenharia da Computação",
	"institution_id": 3
}
```

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Bill's ID: 21 for the student's ID: 6.",
    "data": {
        "id": 21,
        "valor_fatura": "375.0",
        "data_vencimento": "2018-10-20",
        "status": "Aberta",
        "enrollment_id": 6,
        "student_id": 6
    }
}
```