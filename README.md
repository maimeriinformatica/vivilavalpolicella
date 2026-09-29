# Vivi la Valpolicella — sito web

Sito dell'Associazione culturale **Vivi la Valpolicella** (1996–2026) per il dominio **vivilavalpolicella.it**.
Sito statico: una pagina `index.html`, le immagini in `img/` e un piccolo file di configurazione `config.js`.
Non serve nessuna compilazione.

```
index.html          la pagina del sito
config.js           impostazioni (Supabase facoltativo)
img/                fotografie e loghi
render.yaml         configurazione per Render (Static Site)
supabase/schema.sql tabella per i messaggi del modulo contatti (facoltativa)
```

## 1. Caricare su GitHub

1. Su github.com crea un nuovo repository, ad esempio `vivilavalpolicella` (pubblico o privato).
2. Carica tutti i file di questa cartella: dalla pagina del repository scegli **Add file → Upload files**
   e trascina il contenuto della cartella (non la cartella stessa), poi **Commit changes**.

   Oppure da terminale:
   ```bash
   git init
   git add .
   git commit -m "Sito Vivi la Valpolicella"
   git branch -M main
   git remote add origin https://github.com/<utente>/vivilavalpolicella.git
   git push -u origin main
   ```

## 2. Pubblicare su Render

1. Su dashboard.render.com: **New → Static Site** e collega il repository GitHub.
2. Impostazioni:
   - **Build Command:** lascia vuoto
   - **Publish Directory:** `.`
3. **Create Static Site.** In un minuto il sito è online su `https://vivilavalpolicella.onrender.com`.
   (In alternativa **New → Blueprint** legge da solo il file `render.yaml`.)

Ogni volta che modifichi un file su GitHub, Render ripubblica il sito da solo.

### Dominio vivilavalpolicella.it
In Render: **Settings → Custom Domains → Add** `vivilavalpolicella.it` e `www.vivilavalpolicella.it`.
Render mostra i record DNS da inserire presso il registrar del dominio
(di solito un record `A` per il dominio principale e un `CNAME` per `www`). Il certificato HTTPS è automatico.

## 3. Supabase (facoltativo)

**Il sito funziona anche senza Supabase**: il modulo contatti apre il programma di posta
già indirizzato a info@vivilavalpolicella.it.

Supabase serve solo se si vuole che i messaggi del modulo vengano **salvati in un archivio online**
(consultabile dal pannello Supabase), senza dipendere dal programma di posta del visitatore.

1. Crea un progetto su supabase.com (regione Europa, es. Frankfurt).
2. **SQL Editor → New query**: incolla il contenuto di `supabase/schema.sql` e premi **Run**.
   Viene creata la tabella `messaggi` con le regole di sicurezza: i visitatori possono solo *inviare*,
   non leggere.
3. **Project Settings → API**: copia **Project URL** e la chiave **anon / publishable**.
4. Incollale in `config.js`:
   ```js
   window.VLV_CONFIG = {
     supabaseUrl: "https://xxxx.supabase.co",
     supabaseAnonKey: "eyJ..."
   };
   ```
   Non usare mai la chiave `service_role`: è segreta e non va nel sito.
5. Carica il nuovo `config.js` su GitHub: Render aggiorna il sito.

I messaggi si leggono in Supabase → **Table Editor → messaggi** (colonna `letto` per segnare quelli gestiti).

## Da completare prima della pubblicazione

- Elenco dei **soci fondatori** (sezione Chi siamo: segnaposto tratteggiato "elenco da inserire").
- **PDF scaricabili** di bandi e regolamenti (sezione Pubblicazioni).
- Verificare i nomi: sindaco di Negrar, "Campostrini/Compostrini", "Davide Bronbo".
- Una pagina **Privacy e cookie** (obbligatoria se si attiva il salvataggio dei messaggi su Supabase).
- Il sito carica i caratteri da Google Fonts: se si preferisce evitarlo per la privacy, si possono
  ospitare i font nella cartella del sito.

Fotografie di paesaggio © Damolgraf Editore.
