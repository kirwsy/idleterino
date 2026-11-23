# Idleterino no Mac

Precisa de macOS 13 (Ventura) ou mais novo e Node.js 22.12+ (https://nodejs.org).

## Gerar e instalar

Copie a pasta do projeto para o Mac **sem** `node_modules`. No Terminal, dentro dela:

```bash
bash scripts/build-mac.sh
open dist/*.dmg
```

Arraste o Idleterino para Aplicativos. O script também baixa o código criptografado do Trader dessa versão; ele continua pedindo licença.

Só testar, sem instalar: `npm ci && npm start`.

## Pelo GitHub Actions

Suba o projeto para um repositório seu, abra **Actions > Build macOS > Run workflow** e baixe o artefato (arm64 = Apple Silicon, x64 = Intel).

O .dmg baixado não tem assinatura paga da Apple, então o macOS bloqueia a primeira abertura. Se foi você que gerou, use **Ajustes do Sistema > Privacidade e Segurança > Abrir Mesmo Assim**.

## Diferenças no Mac

- O app fica na barra de menus. Fechar a janela não encerra: use ⌘Q.
- Tela cheia: ⌃⌘F.
- O macOS pode pedir acesso às Chaves ("Idleterino Safe Storage"), que criptografa os logins. Pode pedir de novo após cada build.
- Não se atualiza sozinho: atualize o código e rode o script outra vez.
- "Voltar de versão" com um clique só existe no Windows.
- Com o Mac suspenso (tampa fechada), as lives e contas param.
