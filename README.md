# Filmbewertungs-App

Dieses Repo beinhaltet alle notwendigen Entwicklungsobjekte sowie eine Musterlösung zur Entwicklung einer Filmbewertungs-App à la IMDB (siehe auch [Anwendungsentwicklung in SAP S/4HANA - Übungsaufgaben RAP](https://appenmaier.github.io/s4hana/exercises/rap/)). Das Arbeiten mit abapGit-Repos wird [hier](https://appenmaier.github.io/s4hana/additional-material/instructions/use-git-ondemand) beschrieben.

## Aufbau

- Im Paket `ZABAP_MOVIE_FND` befinden sich alle Dictionary-Objekte, die für die Entwicklung der Filmbewertungs-App erforderlich sind, eine Generatorklasse für 15 festgelegte Filme und mehrere zufällige Bewertungen (`ZABAP_MOVIE_GENERATOR`), eine Nachrichtenklasse für Filme (`ZABAP_MOVIE`) sowie eine RAP-Nachrichtenklasse für Filme (`ZCM_ABAP_MOVIE`) und eine abstrakte Oberklasse für RAP-Nachrichten (`ZCM_ABAP`)
- Im Paket `ZABAP_MOVIE_APP` befindet sich eine beispielhafte Implementierung der App

## ER-Modell

```mermaid
erDiagram
   Movie ||--o{ Rating : ""
   Movie {
      clnt(3) Client PK
      raw(16) MovieUuid PK
      char(50) Title
      char(10) Genre
      numc(4) PublishingYear
      int1(3) RuntimeInMin
      sstring(255) ImageUrl
      dec(21-7) CreatedAt
      char(12) CreatedBy
      dec(21-7) LastChangedAt
      char(12) LastChangedBy
   }
   Rating {
      clnt(3) Client PK
      raw(16) RatingUuid PK
      raw(16) MovieUuid FK
      char(50) UserName
      int1(3) Rating
      dats(8) RatingDate
   }
```

## Laufzeitartefakte

```mermaid
block-beta
   columns 1
   block
      space
      space
      space
      UI_MOVIE_O2["UI_MOVIE_O2
                   Service Binding"]
      space
      space
   end
   block
      space
      C_MOVIETP2["C_MOVIETP
                  Metadata Extension"]
      space
      UI_MOVIE["UI_MOVIE
                Service Definition"]
      space
      C_RATINGTP["C_RATINGTP
                  Metadata Extension"]
   end
   block     
      C_MOVIETP["C_MOVIETP
                 Behavior Projection"]
      space
      C_MovieTP["C_MovieTP
                 BO Projection View"]
      space
      C_RatingTP["C_RatingTP
                  BO Projection View"]
      space
   end
   block
      I_MOVIETP["I_MOVIETP
                 Behavior Definition"]
      space
      I_MovieTP["I_MovieTP
                 BO Base View"]
      space
      I_RatingTP["I_RatingTP
                  BO Base View"]
      space
   end
   block
      space
      space
      R_Movie["R_Movie
               Restricted View"]
      space
      R_Rating["R_Rating
                Restricted View"]
      space
   end
   block
      space
      space      
      MOVIE["MOVIE
             Database Table"]
      space
      RATING["RATING
              Database Table"]
      space
   end
   block
      BP_MOVIE["BP_MOVIE
                Behavior Implementation"]
      space
      space
      space
      space
      space
   end
   block
      CM_MOVIE["CM_MOVIE
                RAP Message Class"]
      space
      space
      space
      space
      space
   end

   UI_MOVIE_O2-->UI_MOVIE
   UI_MOVIE-->C_MovieTP
   UI_MOVIE-->C_RatingTP
   C_MovieTP-->I_MovieTP
   C_MOVIETP-->C_MovieTP
   C_MOVIETP2-->C_MovieTP
   C_RATINGTP-->C_RatingTP
   C_RatingTP-->I_RatingTP
   C_MovieTP-->C_RatingTP
   C_RatingTP-->C_MovieTP
   I_MovieTP-->R_Movie
   I_MOVIETP-->I_MovieTP
   I_MOVIETP-->BP_MOVIE
   BP_MOVIE-->CM_MOVIE
   I_MovieTP-->I_RatingTP
   I_RatingTP-->I_MovieTP
   I_RatingTP-->R_Rating
   R_Movie-->MOVIE
   R_Rating-->RATING
```

## Business Object

```mermaid
flowchart
   I_MovieTP["I_MovieTP
              Parent/Root"]
   I_RatingTP["I_RatingTP
               Composition Child"]
   subgraph "I_MOVIETP"
      direction TB
      I_MovieTP --0..*--> I_RatingTP
      I_RatingTP --1..1--> I_MovieTP
   end
```
