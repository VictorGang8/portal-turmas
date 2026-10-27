# Portal de Turmas — UNICEPLAC

> **Descrição baseada no código presente neste repositório.** Este projeto é um exemplo didático de interface web com HTML, CSS, Bootstrap e JSP. Os dados das turmas são definidos estaticamente nos arquivos; o cadastro não grava registros em banco de dados.

## Visão geral

O portal apresenta turmas do 4º período de Engenharia de Software e duas versões da página principal. A versão HTML/CSS usa estilos próprios; a versão Bootstrap usa a biblioteca Bootstrap e contém interações JavaScript. As páginas JSP demonstram a geração de HTML no servidor, validação simples de formulário e uso de sessão.

## Arquivos

| Arquivo | Responsabilidade |
| --- | --- |
| `index.html` | Página principal com CSS próprio, lista estática de turmas e formulário que envia os dados via POST para `processar.jsp`. |
| `estilo.css` | Paleta, layout, tipografia, estilos de formulário, estados de foco, ajustes para telas menores e preferência por movimento reduzido da versão HTML/CSS. |
| `portal-bootstrap.html` | Página principal alternativa, estilizada com Bootstrap 5.3.3 e Bootstrap Icons carregados por CDN. Inclui navegação responsiva, validação no navegador e modo demonstração. |
| `turmas.jsp` | Gera uma tabela de turmas a partir de um array Java definido no próprio JSP e, se houver, exibe o nome do último cadastro armazenado na sessão atual. |
| `processar.jsp` | Recebe POST, valida nome, e-mail e código de turma, guarda o nome validado na sessão e renderiza o resultado. |
| `portal-turmas.zip` | Arquivo ZIP presente na pasta do projeto. Seu conteúdo não é descrito aqui; consulte o arquivo diretamente antes de usá-lo. |

## Funcionalidades

- Exibe três turmas: Programação para Web, Banco de Dados e Engenharia de Software.
- Oferece navegação por âncoras, links entre as páginas e informações de contato que já estão no HTML.
- Apresenta formulários com nome, e-mail e turma. A validação do navegador ajuda o usuário, enquanto `processar.jsp` também valida os dados recebidos no servidor.
- A lista JSP percorre os dados estáticos com Java e gera as linhas da tabela.
- O JSP usa a sessão HTTP para manter o nome do último cadastro válido daquela sessão, que pode ser mostrado em `turmas.jsp`.

## Fluxo de cadastro

### Página `index.html`

O formulário envia `nome`, `email` e `turma` por POST para `processar.jsp`. O navegador verifica os atributos HTML, como `required`, `minlength` e `type="email"`. Essas verificações não substituem a validação no servidor.

### Página `portal-bootstrap.html`

No código atual, `MODO_DEMO` está definido como `true`. Após a validação no navegador, o JavaScript impede o envio ao JSP, mostra uma notificação local e limpa o formulário. Portanto, essa página não realiza um cadastro no servidor enquanto permanecer nesse modo. Com `MODO_DEMO` em `false`, o envio segue para `processar.jsp`, desde que a página seja servida em um ambiente com suporte a JSP.

### Processamento em `processar.jsp`

O JSP aceita somente requisições POST e redireciona outros métodos para o formulário Bootstrap. Ele define a codificação UTF-8 antes de ler os parâmetros, remove espaços externos do nome e do e-mail, exige nome com pelo menos três caracteres, verifica o formato básico do e-mail e aceita apenas os códigos `web`, `bd` e `es`. Se os campos forem válidos, guarda o nome em `ultimoCadastro` na sessão e mostra nome, e-mail e turma na resposta.

O JSP escapa caracteres HTML nos valores de nome, e-mail e turma exibidos na página de resultado. `turmas.jsp` também escapa o nome de sessão antes de exibi-lo. Esses cuidados reduzem o risco de injeção de marcação nesses pontos de saída, mas não equivalem a uma revisão completa de segurança da aplicação.

## Requisitos e execução

- Para abrir as páginas estáticas, use um navegador. `index.html` carrega `estilo.css` por caminho relativo.
- Para executar `processar.jsp` e `turmas.jsp`, use um contêiner Java Servlet/JSP compatível, como Apache Tomcat, com esta pasta publicada como uma aplicação web. Abrir os arquivos JSP diretamente no navegador não executa o código Java.
- As versões Bootstrap dependem de acesso ao jsDelivr para carregar Bootstrap 5.3.3, Bootstrap Icons 1.11.3 e, no caso de `portal-bootstrap.html`, o JavaScript do Bootstrap. Sem esses recursos, parte da apresentação e das interações pode não funcionar como esperado.
- O código usa caminhos relativos, como `processar.jsp` e `turmas.jsp`. O endereço de acesso depende do nome/contexto usado para publicar a aplicação no servidor.

## Dados e persistência

As turmas estão codificadas diretamente em `index.html`, `portal-bootstrap.html` e `turmas.jsp`; não há integração com banco de dados declarada nos arquivos examinados. O cadastro não cria um registro permanente: o JSP guarda somente o nome na sessão HTTP. O nome fica disponível enquanto aquela sessão existir, conforme o comportamento do contêiner; não é uma lista compartilhada de alunos nem um histórico durável. O e-mail é exibido na resposta do cadastro, mas não é armazenado pelo código em sessão ou banco.

## Segurança e privacidade

- Não inclua credenciais, chaves, tokens, dados reais de alunos ou outras informações pessoais neste README ou em arquivos versionados.
- Use dados fictícios ao demonstrar ou avaliar o formulário. O projeto não implementa armazenamento persistente, gestão de consentimento ou controles de acesso para dados pessoais.
- A validação de e-mail é uma verificação de formato simples; não confirma que o endereço existe ou pertence à pessoa.
- A validação de nome e turma é limitada às regras implementadas no JSP. O código não documenta limites de tamanho de requisição, proteção CSRF, limitação de tentativas, autenticação, autorização ou política de retenção. Não trate este exemplo como pronto para uso com dados reais sem uma avaliação e implementação desses controles.
- As dependências de interface são carregadas de um CDN externo. Em um uso com requisitos de disponibilidade, privacidade ou integridade mais rigorosos, avalie como esses recursos serão fornecidos e controlados.
- Os dados de professores e instituição reproduzem conteúdo que já está escrito nas páginas. Confirme a atualidade e a autorização para publicar essas informações antes de reutilizar o projeto fora do contexto acadêmico.

## Escopo

Este README descreve o comportamento observável nos arquivos HTML, CSS e JSP listados acima. Não presume configuração de servidor, estrutura de banco de dados, processo de implantação, testes automatizados ou funcionalidades que não aparecem no código examinado.
