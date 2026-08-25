# Como Adicionar um Novo Tenant (Flavor)

Este guia é o passo a passo definitivo para adicionar um novo tenant ao projeto. Ele reflete a arquitetura atual, que automatiza a maior parte da configuração do Android a partir de arquivos de propriedades e utiliza um backend para o branding dinâmico na web.

**Placeholders Usados:**
* `<novo_tenant>`: O nome do novo flavor em minúsculas (ex: `tenantalpha`).
* `<NomeDoApp>`: O nome de exibição do aplicativo (ex: `Tenant Alpha App`).
* `<com.empresa.novoapp>`: O ID único do aplicativo para a loja (ex: `com.example.tenantalpha.app`).

## Telemetry e Push

O bootstrap Flutter usa a origem de `main_domain` retornada pelo endpoint de ambiente e monta o transporte em `/api/v1/`. `APP_URL` não deve ser transformada em subdomínio do tenant para esse fluxo.

O backend pode fornecer configurações opcionais em `telemetry_settings.trackers` e `firebase_settings`. Sem essas configurações, o app mantém o startup funcional, não usa credenciais hardcoded e deixa a entrega externa desabilitada. A integração usa `event_tracker_handler` e `push_handler` na linha `0.2.x`, com `$insert_id`, outcomes, bearer token, fetch de dados e action reporting fornecidos pelos pacotes.

O boilerplate possui rota própria para detalhe de evento (`/agenda/:event_id`), mas não possui domínio ou rota de convites. Payloads de convite são ignorados com segurança até existir um TODO específico para essa superfície. Chrome/web é um alvo aceito para testes; configuração real Android/iOS, Firebase files e credenciais não fazem parte do baseline genérico.

### Pré-requisitos
* Acesso ao `keytool` (parte do JDK).
* Acesso a um ambiente macOS com Xcode para a configuração do iOS.
* Dependências `flutter_launcher_icons` e `flutter_native_splash` configuradas.

---

### Passo 1: Configuração do Backend
1.  **Cadastrar o Tenant:** Adicione o novo tenant ao seu banco de dados, incluindo seu `applicationId` para mobile e os domínios/subdomínios para web.
2.  **Upload do Logo:** Use o endpoint de upload para enviar o logo principal do tenant. O backend se encarregará de gerar todos os tamanhos necessários (`favicon`, PWA, splash) e armazenar suas URLs públicas.

---

### Passo 2: Configuração da Assinatura (Android)

1.  **Gerar Keystore:** Gere o arquivo `.jks` para o novo tenant e coloque-o na pasta `android/keystores/`.
    ```bash
    keytool -genkey -v -keystore <novo_tenant>-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias <novo_tenant>-alias
    ```

2.  **Criar Arquivo de Propriedades:**
    * Na pasta `android/keystores/`, copie o arquivo `tenant.properties.example` e renomeie-o para `<novo_tenant>.properties`. Exemplos neutros:
        * `tenantalpha.properties` → `applicationId=com.example.tenantalpha.app`, alias `tenantalpha-alias`, campos de assinatura definidos pelo seu time.
        * `tenantbeta.properties` → `applicationId=com.example.tenantbeta.app`, alias `tenantbeta-alias`, campos de assinatura definidos pelo seu time.
    * Abra o novo arquivo e preencha todos os placeholders com os valores reais do tenant, além de definir o nome do arquivo `.jks` (ex.: `tenantalpha-release-key.jks`) que deve estar dentro desta mesma pasta.

---

### Passo 3: Geração de Ícones e Splash Screen (Mobile)

1.  **Preparar Imagens:** Adicione os arquivos de imagem de alta resolução nas pastas de assets do tenant:
    * `assets/tenants/<novo_tenant>/launcher_icons/adaptive_icon_foreground.png`
    * `assets/tenants/<novo_tenant>/splash_screen/splash_logo.png`

2.  **Criar Arquivos de Configuração YAML:** Crie os dois arquivos de configuração **dentro** da pasta do tenant.
    * Crie `assets/tenants/<novo_tenant>/flutter_icons.yaml` para o **ícone do app**.
        ```yaml
        flutter_launcher_icons:
          android: true
          ios: true
          image_path: "assets/tenants/<novo_tenant>/launcher_icons/adaptive_icon_foreground.png"
          # ... outras configs de ícone adaptativo ...
        ```
    * Crie `assets/tenants/<novo_tenant>/splash.yaml` para a **splash screen**.
        ```yaml
        flutter_native_splash:
          web: false # Importante para não interferir com a solução web
          color: "#FFFFFF"
          image: "assets/tenants/<novo_tenant>/splash_screen/splash_logo.png"
          android_12:
            color: "#FFFFFF"
            image: "assets/tenants/<novo_tenant>/splash_screen/splash_logo.png"
        ```

3.  **Executar os Geradores:** Os comandos agora devem apontar para os caminhos corretos dos arquivos de configuração.
    ```bash
    # Gerar o ícone do app
    dart run flutter_launcher_icons -f assets/tenants/<novo_tenant>/flutter_icons.yaml

    # Gerar a splash screen
    dart run flutter_native_splash:create --path=assets/tenants/<novo_tenant>/splash.yaml
    ```

4.  **Organizar Ícones Gerados (Passo Manual):**
    * **Android:** Mova as pastas `mipmap-*`/`drawable-*` geradas em `android/app/src/main/res/` para a pasta `android/app/src/`**`<novo_tenant>`**`/res/`.
    * **iOS:** No Finder, renomeie `ios/Runner/Assets.xcassets/AppIcon.appiconset` para `AppIcon-<novo_tenant>.appiconset`. Arraste o novo asset para o Xcode e, nas **Build Settings**, configure o **Asset Catalog App Icon Set Name** para `AppIcon-<novo_tenant>`.

---

### Passo 4: Configuração Nativa (Android & iOS)

* **Android:**
    1.  Crie a pasta `android/app/src/<novo_tenant>/res/values/`.
    2.  Crie um arquivo `strings.xml` dentro dela para definir o `<string name="app_name">`.

* **iOS (via Xcode):**
    1.  Duplique as Configurações de Build para `Debug-<novo_tenant>` e `Release-<novo_tenant>`.
    2.  Crie e configure um novo "Scheme" chamado `<novo_tenant>`.
    3.  Nas Build Settings, defina o **Product Bundle Identifier** e **APP_DISPLAY_NAME**.
    4.  Configure a equipe de assinatura (Signing Team) correta.

---

### Passo 5: Configuração do Código Dart

O `TenantRepository` identifica o tenant comparando o **ID do aplicativo** com a lista `AppDomains` de cada tenant. Garanta que o `<com.empresa.novoapp>` esteja incluído na fonte de dados que o `TenantRepository` consulta (seja um JSON local ou uma resposta de API).

---

### Passo 6: Configuração do VS Code

Abra `.vscode/launch.json` e adicione uma nova configuração de execução para o `<novo_tenant>`, incluindo os `args` para `--flavor` e `--dart-define`.

---

### Passo 7: Verificação e Build Final

1.  **Limpe o projeto:**
    ```bash
    fvm flutter clean
    ```
2.  **Teste em Debug (Mobile):**
    ```bash
    fvm flutter run --flavor <novo_tenant> --dart-define=FLAVOR=<novo_tenant>
    ```
3.  **Gere o App Bundle para a Google Play:**
    ```bash
    fvm flutter build appbundle --flavor <novo_tenant>
    ```
4.  **Teste a Web:** Acesse o domínio/subdomínio correspondente. O branding deve ser carregado dinamicamente do backend.
