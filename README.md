# :money_with_wings: Billinho :mortar_board:


## Informações da API
* Todos endpoints retornam um objeto JSON;
* A resposta de cada requisição possui seu código corresponde da tabela de códigos de status de respostas HTTP;
* CORS habilitado;
* Utilização do PostgreSQL como SGBD.






## 1. Instituição

A seguir são descritos os endpoints referentes a entidade Instituição.

### 1.1 Obter todas as instituições

**Descrição:** Retorna todas as instituições contidas no banco de dados.

**Verbo HTTP e rota**:
```
GET /v1/institutions
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
            "nome": "Nome Instituição",
            "cnpj": "0123456789",
            "tipo": "Universidade"
        },
        {
        ...
        }
    ]
}
```

### 1.2 Obter uma única instituição

**Descrição:** Retorna, caso exista, a instituição que corresponde ao ID passado como parâmetro.

**Verbo HTTP e rota:**
```
GET /v1/institutions/:id
```

**Parâmetro(s):** ID da Instituição.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": "Institution with ID: 1."
    "data": 
        {
            "id": 1,
            "nome": "Nome Instituição",
            "cnpj": "0123456789",
            "tipo": "Universidade"
        }
}
```

### 1.3 Inserir uma nova instituição

**Descrição:** Insere, caso não exista, a instituição no banco de dados.

**Verbo HTTP e rota:**
```
POST /v1/institutions
```

**Parâmetro(s):** nenhum.

**Estrutura da requisição:**
Nome | Tipo | Mandatorio | Restrição | Descrição
---- | ---- | ---------- | --------- | ---------
nome | texto | Sim | Não pode estar vazio e deve ser único | Descreve o nome da instituição
cnpj | texto | Sim | Deve conter apenas caracteres numéricos e deve ser único | Descreve o CNPJ da instituição
tipo | texto | Sim | Deve ser: Universidade, Escola ou Creche | Descreve o tipo da instituição

**Estrutura do body da requisição:**
```javascript
{
    "nome": "Nome Instituição",
    "cnpj": "0123456789",
    "tipo": "Universidade"
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Institution saved"
    "data": 
        {
            "id": 1,
            "nome": "Nome Instituição",
            "cnpj": "0123456789",
            "tipo": "Universidade"
        }
}
```




## 2. Aluno

A seguir são descritos os endpoints referentes a entidade Aluno.

### 2.1 Obter todos os alunos

**Descrição:** Retorna todos os alunos contidos no banco de dados.

**Verbo HTTP e rota:**
```
GET /v1/students
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
            "nome_estudante": "Nome Estudante",
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

### 2.2 Obter um único aluno

**Descrição:** Retorna, caso exista, o aluno que corresponde ao ID passado como parâmetro.

**Verbo HTTP e rota:**
```
GET /v1/students/:id
```

**Parâmetro(s):** ID do estudante.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": ""Student with ID: 1.",
    "data": 
        {
            "id": 1,
            "nome_estudante": "Nome Estudante",
            "cpf": "0123456789",
            "data_nascimento": "1994-05-20",
            "telefone_celular": 12981818080,
            "genero": "M",
            "tipo_pagamento": "Cartão"
        }
}
```

### 2.3 Inserir um novo aluno

**Descrição:** Insere, caso não exista, a instituição no banco de dados.

**Verbo HTTP e rota:**
```
POST /v1/students
```

**Parâmetro(s):** nenhum.

**Estrutura da requisição:**
Nome | Tipo | Mandatorio | Restrição | Descrição
---- | ---- | ---------- | --------- | ---------
nome_estudante | texto | Sim | Deve ser único e não pode estar vazio | Descreve o nome do aluno
cpf | texto | Sim | Deve conter apenas caracteres numéricos, deve ser único e não pode estar vazio | Descreve o CPF do aluno
data_nascimento | texto | Não |  | Descreve a data de nascimento do aluno no formato YYYY-MM-DD
telefone_celular | inteiro | Não |  | Descreve o telefone do aluno
genero | texto | Sim | Não pode ser vazio e tem que estar entre M ou F | Descreve o gênero do aluno
tipo_pagamento | texto | Sim | Não pode ser vazio e tem que estar entre Boleto ou Cartão | Descreve o tipo de pagamento

**Estrutura do body da requisição:**
```javascript
{
    "nome_estudante": "Nome Estudante",
    "cpf": "0123456789",
    "data_nascimento": "1994-05-20",
    "telefone_celular": 12981818080,
    "genero": "M",
    "tipo_pagamento": "Cartão"
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Student saved.",
    "data": 
        {
            "id": 1,
            "nome_estudante": "Nome Estudante",
            "cpf": "0123456789",
            "data_nascimento": "1994-05-20",
            "telefone_celular": 12981818080,
            "genero": "M",
            "tipo_pagamento": "Cartão"
        }
}
```


## 3. Matrícula

A seguir são descritos os endpoints referentes a entidade Matrícula.

### 2.1 Obter todas as matrículas

**Descrição:** Retorna todas as matrículas contidas no banco de dados.

**Verbo HTTP e rota:**
```
GET /v1/enrollments
```

**Parâmetro(s):** nenhum.

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "All enrollments.",
    "data": [
        {
            "id": 1,
            "student_id": 5,
            "institution_id": 2",
            "nome_curso": "Engenharia da Computação",
            "valor_total": 1500.00,
            "qtd_faturas": 5,
            "dia_vencimento": 20
        },
        {
        ...
        }
    ]
}
```

### 2.2 Obter uma única matrícula

**Descrição:** Retorna, caso exista, a matrícula que corresponda ao ID passado como parâmetro.

**Verbo HTTP e rota:**
```
GET /v1/enrollments/:id
```

**Parâmetro(s):** ID da matrícula.

**Resposta:**
```javascript
{
    "status": "Success",
    "message": ""Student with ID: 1.",
    "data": 
        {

        }
}
```

### 2.3 Inserir um novo aluno

**Descrição:** Insere, caso não exista, a instituição no banco de dados.

**Verbo HTTP e rota:**
```
POST /v1/students
```

**Parâmetro(s):** nenhum.

**Estrutura da requisição:**
Nome | Tipo | Mandatorio | Restrição | Descrição
---- | ---- | ---------- | --------- | ---------
nome_estudante | texto | Sim | Deve ser único e não pode estar vazio | Descreve o nome do aluno
cpf | texto | Sim | Deve conter apenas caracteres numéricos, deve ser único e não pode estar vazio | Descreve o CPF do aluno
data_nascimento | texto | Não |  | Descreve a data de nascimento do aluno no formato YYYY-MM-DD
telefone_celular | inteiro | Não |  | Descreve o telefone do aluno
genero | texto | Sim | Não pode ser vazio e tem que estar entre M ou F | Descreve o gênero do aluno
tipo_pagamento | texto | Sim | Não pode ser vazio e tem que estar entre Boleto ou Cartão | Descreve o tipo de pagamento

**Estrutura do body da requisição:**
```javascript
{
    "nome_estudante": "Nome Estudante",
    "cpf": "0123456789",
    "data_nascimento": "1994-05-20",
    "telefone_celular": 12981818080,
    "genero": "M",
    "tipo_pagamento": "Cartão"
}
```

**Estrutura da resposta:**
```javascript
{
    "status": "Success",
    "message": "Student saved.",
    "data": 
        {
            "id": 1,
            "nome_estudante": "Nome Estudante",
            "cpf": "0123456789",
            "data_nascimento": "1994-05-20",
            "telefone_celular": 12981818080,
            "genero": "M",
            "tipo_pagamento": "Cartão"
        }
}
```