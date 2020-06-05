# Spotify Browse API Docs

<br>

`Spotify`의 `Brwose` 탭에서 플레이리스트, 새롭게 발매된 앨범, 추천된 재생 목록 등을 얻어오기 위한 API 모음


# Browse

Base URL : `https://api.spotify.com/v1`

Browse 카테고리에는 총 6가지 API가 존재한다.

<br>

## Get a Category
---

> `Spotify` 에서 항목을 **태그**하는데 사용되는 카테고리를 가져온다.


<br>

### EndPoint
```
GET https://api.spotify.com/v1/browse/categories/{category_id}
```

<br>

### Request parameters


**Path Parameter**
- `category_id` : `Spotify` 에서 이용되는 카테고리명을 의미한다.


**Header Parameters**
- `Authorization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰을 의미한다.

<br>

### Query Parameters

- `country` : (옵션), 특정 국가의 카테고리가 존재하도록 하려면 해당 매개변수를 사용한다.

- `locale` : (옵션), 반환받는 카테고리값이 특정 국가의 언어로 리턴되도록 하려면 해당 매개변수를 사용한다.

<br>

### category object

성공적으로 반환값 카테고리를 받아왔을 경우, 

```json
{
  "href" : "https://api.spotify.com/v1/browse/categories/party",
  "icons" : [ {
    "height" : 274,
    "url" : "https://datsnxq1rwndn.cloudfront.net/media/derived/party-274x274_73d1907a7371c3bb96a288390a96ee27_0_0_274_274.jpg",
    "width" : 274
  } ],
  "id" : "party",
  "name" : "Party"
}
```

- `href` : String, 카테고리의 전체 세부 사항을 리턴하는 사이트로 연결되는 링크

- `icons` : [UIImage], 카테고리의 다양한 사이즈의 아이콘

- `id` : String, `Spotify`의 카테고리 ID값

- `name` : 카테고리 명

<br>

## Get a Category's Playlists
---

> 특정 카테고리로 태그 지정된 `Spotify` 재생 목록을 가져온다.

<br>

### EndPoint
```
GET https://api.spotify.com/v1/browse/categories/{category_id}/playlists
```

<br>

### Request Parameters

**Path Parameters**

- `category_id` : 카테고리의 `Spotify` 카테고리명

**Header Fields**

- `Authorization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰

<br>

### Query Parameters

- `country` : (옵션), 국가명 - country code

- `limit` : (옵션), 반환할 아이템의 최대 갯수 (default: 20, maximum: 50, minimum: 1)

- `offset` : (옵션), 반환할 값의 첫번째 아이템 인덱스

<br>

### playlist object

```json
{
  "playlists" : {
    "href" : "https://api.spotify.com/v1/browse/categories/party/playlists?country=BR&offset=0&limit=2",
    "items" : [ {
      "collaborative" : false,
      "description" : "Chegou o grande dia, aperte o play e partiu fim de semana!",
      "external_urls" : {
        "spotify" : "https://open.spotify.com/playlist/37i9dQZF1DX8mBRYewE6or"
      },
      "href" : "https://api.spotify.com/v1/playlists/37i9dQZF1DX8mBRYewE6or",
      "id" : "37i9dQZF1DX8mBRYewE6or",
      "images" : [ {
        "height" : 300,
        "url" : "https://i.scdn.co/image/ab67706f00000002206a95fa5badbe1d33b65e14",
        "width" : 300
      } ],
      "name" : "Sexta",
      "owner" : {
        "display_name" : "Spotify",
        "external_urls" : {
          "spotify" : "https://open.spotify.com/user/spotify"
        },
        "href" : "https://api.spotify.com/v1/users/spotify",
        "id" : "spotify",
        "type" : "user",
        "uri" : "spotify:user:spotify"
      },
      "primary_color" : null,
      "public" : null,
      "snapshot_id" : "MTU3NDM1NjI0MiwwMDAwMDAwMGQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0Mjdl",
      "tracks" : {
        "href" : "https://api.spotify.com/v1/playlists/37i9dQZF1DX8mBRYewE6or/tracks",
        "total" : 62
      },
      "type" : "playlist",
      "uri" : "spotify:playlist:37i9dQZF1DX8mBRYewE6or"
    }, {
      "collaborative" : false,
      "description" : "O batidão dos funks mais bombados pra agitar a pista do seu baile! [Conteúdo explícito]",
      "external_urls" : {
        "spotify" : "https://open.spotify.com/playlist/37i9dQZF1DWWmaszSfZpom"
      },
      "href" : "https://api.spotify.com/v1/playlists/37i9dQZF1DWWmaszSfZpom",
      "id" : "37i9dQZF1DWWmaszSfZpom",
      "images" : [ {
        "height" : 300,
        "url" : "https://pl.scdn.co/images/pl/default/68fae5be6747e445c6bb34655c2bc2a77b9d1439",
        "width" : 300
      } ],
      "name" : "Segue o Baile",
      "owner" : {
        "display_name" : "Spotify",
        "external_urls" : {
          "spotify" : "https://open.spotify.com/user/spotify"
        },
        "href" : "https://api.spotify.com/v1/users/spotify",
        "id" : "spotify",
        "type" : "user",
        "uri" : "spotify:user:spotify"
      },
      "primary_color" : null,
      "public" : null,
      "snapshot_id" : "MTU3MzEyOTM2OCwwMDAwMDA5MDAwMDAwMTZlNDVkMTM0MmMwMDAwMDE2ZGNjMTY1NTFh",
      "tracks" : {
        "href" : "https://api.spotify.com/v1/playlists/37i9dQZF1DWWmaszSfZpom/tracks",
        "total" : 67
      },
      "type" : "playlist",
      "uri" : "spotify:playlist:37i9dQZF1DWWmaszSfZpom"
    } ],
    "limit" : 2,
    "next" : "https://api.spotify.com/v1/browse/categories/party/playlists?country=BR&offset=2&limit=2",
    "offset" : 0,
    "previous" : null,
    "total" : 37
  }
}
```



- `collaborative` : Boolean, 플레이리스트 소유자가 다른 사용자가 재생 목록 수정을 허용하는 경우

- `description` : String, 재생 목록 설명

- `external_urls` : 플레이리스트로 연결되는 외부 URL

- `href` : 플레이리스트에 관한 상세 설명으로 연결되는 link

- `id` : 플레이리스트를 위한 Spotify ID

- `images` : 플레이리스트를 위한 사진

- `name` : 플레이리스트명

- `owner` : 플레이리스트 주인

- `public` : 플레이리스트 공개 여부

<br>

## Get a List of Catregories

> `Spotify` 내에서 사용된 태그를 이용하여 카테고리 리스트를 받아오기 위한 API

<br>

### Endpoint
```
GET https://api.spotify.com/v1/browse/categories
```

<br>

### Request Parameters

**Header Field**

- `Authorization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰

<br>

### Query Parameters

- `country` : 특정 국가와 관련된 카테고리를 얻고자 할 때 사용

- `locale` : 반환값의 언어를 지정하고자 할 때 사용

- `limit`  : 카테고리의 갯수 제한 (default: 20, maximum: 50, minimum: 1)

- `offset` : 반환하는 아이템의 첫번째 아이템 인덱스 값

<br>

### category obejct

- `href` : 카테고리에 대한 상세 설명 페이지로 연결하는 링크

- `icons` : 다양한 사이즈의 카테고리 아이콘

- `id` : `Spotify` 카테고리 ID

- `name` : 카테고리의 이름




```json
{
  "categories" : {
    "href" : "https://api.spotify.com/v1/browse/categories?offset=0&limit=20",
    "items" : [ {
      "href" : "https://api.spotify.com/v1/browse/categories/toplists",
      "icons" : [ {
        "height" : 275,
        "url" : "https://datsnxq1rwndn.cloudfront.net/media/derived/toplists_11160599e6a04ac5d6f2757f5511778f_0_0_275_275.jpg",
        "width" : 275
      } ],
      "id" : "toplists",
      "name" : "Top Lists"
    }, {
      "href" : "https://api.spotify.com/v1/browse/categories/mood",
      "icons" : [ {
        "height" : 274,
        "url" : "https://datsnxq1rwndn.cloudfront.net/media/original/mood-274x274_976986a31ac8c49794cbdc7246fd5ad7_274x274.jpg",
        "width" : 274
      } ],
      "id" : "mood",
      "name" : "Mood"
    }, {
      "href" : "https://api.spotify.com/v1/browse/categories/party",
      "icons" : [ {
        "height" : 274,
        "url" : "https://datsnxq1rwndn.cloudfront.net/media/derived/party-274x274_73d1907a7371c3bb96a288390a96ee27_0_0_274_274.jpg",
        "width" : 274
      } ],
      "id" : "party",
      "name" : "Party"
    }, {
      "href" : "https://api.spotify.com/v1/browse/categories/pop",
      "icons" : [ {
        "height" : 274,
        "url" : "https://datsnxq1rwndn.cloudfront.net/media/derived/pop-274x274_447148649685019f5e2a03a39e78ba52_0_0_274_274.jpg",
        "width" : 274
      } ],
      "id" : "pop",
      "name" : "Pop"
    }, {
      "href" : "https://api.spotify.com/v1/browse/categories/workout",
      "icons" : [ {
        "height" : 275,
        "url" : "https://datsnxq1rwndn.cloudfront.net/media/derived/workout_856581c1c545a5305e49a3cd8be804a0_0_0_275_275.jpg",
        "width" : 275
      } ],
      "id" : "workout",
      "name" : "Workout"
    }, ... ],
    "limit" : 20,
    "next" : "https://api.spotify.com/v1/browse/categories?offset=20&limit=20",
    "offset" : 0,
    "previous" : null,
    "total" : 31
  }
}
```

<br>

## Get a List of Featured Playlists

> `Spotify`의 추천 재생목록을 가져온다.

<br>

### Endpoint
```
GET https://api.spotify.com/v1/browse/featured-playlists
```

### Request Parameters

**Header Fields**

- `Authrization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰

<br>

### Query Parameters

- `locale` : 반환값의 언어를 지정하고자 할 때 사용

- `country` : 특정 국가와 관련된 리스트를 얻고자 할 때 사용

- `timestamp`  : `yyyy-MM-ddTHH:mm:ss` 포맷, 사용핮 현지 시간을 지정하여 하루 중 특정 날짜 및 시간에 맞게 결과를 조정할 수 있다.

- `limit` : 반환값의 최대 개수 지정 (default: 20, maximum: 50, minimum: 1)

- `offset` : 반환값의 첫번째 아이템의 인덱스 반환

```json
{
  "message" : "Monday morning music, coming right up!",
  "playlists" : {
    "href" : "https://api.spotify.com/v1/browse/featured-playlists?country=SE&timestamp=2015-05-18T06:44:32&offset=0&limit=2",
    "items" : [ {
      "collaborative" : false,
      "description" : "Relaxed deep house to slowly help you get back on your feet and ready yourself for a productive week.",
      "external_urls" : {
        "spotify" : "http://open.spotify.com/user/spotify/playlist/6ftJBzU2LLQcaKefMi7ee7"
      },
      "href" : "https://api.spotify.com/v1/users/spotify/playlists/6ftJBzU2LLQcaKefMi7ee7",
      "id" : "6ftJBzU2LLQcaKefMi7ee7",
      "images" : [ {
        "height" : 300,
        "url" : "https://i.scdn.co/image/7bd33c65ebd1e45975bbcbbf513bafe272f033c7",
        "width" : 300
      } ],
      "name" : "Monday Morning Mood",
      "owner" : {
        "external_urls" : {
          "spotify" : "http://open.spotify.com/user/spotify"
        },
        "href" : "https://api.spotify.com/v1/users/spotify",
        "id" : "spotify",
        "type" : "user",
        "uri" : "spotify:user:spotify"
      },
      "public" : null,
      "snapshot_id" : "WwGvSIVUkUvGvqjgj/bQHlRycYmJ2TkoIxYfoalWlmIZT6TvsgvGMgtQ2dGbkrAW",
      "tracks" : {
        "href" : "https://api.spotify.com/v1/users/spotify/playlists/6ftJBzU2LLQcaKefMi7ee7/tracks",
        "total" : 245
      },
      "type" : "playlist",
      "uri" : "spotify:user:spotify:playlist:6ftJBzU2LLQcaKefMi7ee7"
    }, {
      "collaborative" : false,
      "description" : "Du kommer studsa ur sängen med den här spellistan.",
      "external_urls" : {
        "spotify" : "http://open.spotify.com/user/spotify__sverige/playlist/4uOEx4OUrkoGNZoIlWMUbO"
      },
      "href" : "https://api.spotify.com/v1/users/spotify__sverige/playlists/4uOEx4OUrkoGNZoIlWMUbO",
      "id" : "4uOEx4OUrkoGNZoIlWMUbO",
      "images" : [ {
        "height" : 300,
        "url" : "https://i.scdn.co/image/24aa1d1b491dd529b9c03392f350740ed73438d8",
        "width" : 300
      } ],
      "name" : "Upp och hoppa!",
      "owner" : {
        "external_urls" : {
          "spotify" : "http://open.spotify.com/user/spotify__sverige"
        },
        "href" : "https://api.spotify.com/v1/users/spotify__sverige",
        "id" : "spotify__sverige",
        "type" : "user",
        "uri" : "spotify:user:spotify__sverige"
      },
      "public" : null,
      "snapshot_id" : "0j9Rcbt2KtCXEXKtKy/tnSL5r4byjDBOIVY1dn4S6GV73EEUgNuK2hU+QyDuNnXz",
      "tracks" : {
        "href" : "https://api.spotify.com/v1/users/spotify__sverige/playlists/4uOEx4OUrkoGNZoIlWMUbO/tracks",
        "total" : 38
      },
      "type" : "playlist",
      "uri" : "spotify:user:spotify__sverige:playlist:4uOEx4OUrkoGNZoIlWMUbO"
    } ],
    "limit" : 2,
    "next" : "https://api.spotify.com/v1/browse/featured-playlists?country=SE&timestamp=2015-05-18T06:44:32&offset=2&limit=2",
    "offset" : 0,
    "previous" : null,
    "total" : 12
  }
}
```

<br>

## Get a List of New Releases

> 새로 발매된 앨범의 리스트를 가져올 때 사용한다.

<br>

### Endpoint
```
GET https://api.spotify.com/v1/browse/new-releases
```

<br>

### Request Parameters

**Header Fields**

- `Authorization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰

<br>

### Query Parameters

- `country` : 특정 국가에 관련된 앨범 리스트를 받아오고자 할 때 사용

- `limit` : 반환값의 개수 지정시 사용 (default: 20, maximum: 50, minimum: 1)

- `offset` : 반환값의 첫번째 아이템의 인덱스 값 

<br>

### album object

- `album_type`  : 앨범의 타입 지정 (album, single, compilation)

- `artists` : 앨범의 아티스트명

- `available_markets` : 현재 앨범이 사용 가능한 국가 나열

- `external_urls` : 앨범으로 연결하기 위한 알려진 외부 URL

- `href` : 앨범의 상세 설명을 포함하는 link

- `id` : 앨범의 `Spotify` ID

- `images` : 앨범의 커버 사진

- `name` : 앨범의 제목

- `type` : 앨범의 타입

- `uri` : 앨범의 `Spotify URI`

```json
{
  "albums" : {
    "href" : "https://api.spotify.com/v1/browse/new-releases?country=SE&offset=0&limit=20",
    "items" : [ {
      "album_type" : "single",
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/2RdwBSPQiwcmiDo9kixcl8"
        },
        "href" : "https://api.spotify.com/v1/artists/2RdwBSPQiwcmiDo9kixcl8",
        "id" : "2RdwBSPQiwcmiDo9kixcl8",
        "name" : "Pharrell Williams",
        "type" : "artist",
        "uri" : "spotify:artist:2RdwBSPQiwcmiDo9kixcl8"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "external_urls" : {
        "spotify" : "https://open.spotify.com/album/5ZX4m5aVSmWQ5iHAPQpT71"
      },
      "href" : "https://api.spotify.com/v1/albums/5ZX4m5aVSmWQ5iHAPQpT71",
      "id" : "5ZX4m5aVSmWQ5iHAPQpT71",
      "images" : [ {
        "height" : 640,
        "url" : "https://i.scdn.co/image/e6b635ebe3ef4ba22492f5698a7b5d417f78b88a",
        "width" : 640
      }, {
        "height" : 300,
        "url" : "https://i.scdn.co/image/92ae5b0fe64870c09004dd2e745a4fb1bf7de39d",
        "width" : 300
      }, {
        "height" : 64,
        "url" : "https://i.scdn.co/image/8a7ab6fc2c9f678308ba0f694ecd5718dc6bc930",
        "width" : 64
      } ],
      "name" : "Runnin'",
      "type" : "album",
      "uri" : "spotify:album:5ZX4m5aVSmWQ5iHAPQpT71"
    }, {
      "album_type" : "single",
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/3TVXtAsR1Inumwj472S9r4"
        },
        "href" : "https://api.spotify.com/v1/artists/3TVXtAsR1Inumwj472S9r4",
        "id" : "3TVXtAsR1Inumwj472S9r4",
        "name" : "Drake",
        "type" : "artist",
        "uri" : "spotify:artist:3TVXtAsR1Inumwj472S9r4"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "UY" ],
      "external_urls" : {
        "spotify" : "https://open.spotify.com/album/0geTzdk2InlqIoB16fW9Nd"
      },
      "href" : "https://api.spotify.com/v1/albums/0geTzdk2InlqIoB16fW9Nd",
      "id" : "0geTzdk2InlqIoB16fW9Nd",
      "images" : [ {
        "height" : 640,
        "url" : "https://i.scdn.co/image/d40e9c3d22bde2fbdb2ecc03cccd7a0e77f42e4c",
        "width" : 640
      }, {
        "height" : 300,
        "url" : "https://i.scdn.co/image/dff06a3375f6d9b32ecb081eb9a60bbafecb5731",
        "width" : 300
      }, {
        "height" : 64,
        "url" : "https://i.scdn.co/image/808a02bd7fc59b0652c9df9f68675edbffe07a79",
        "width" : 64
      } ],
      "name" : "Sneakin’",
      "type" : "album",
      "uri" : "spotify:album:0geTzdk2InlqIoB16fW9Nd"
    }, {
    ...
    } ],
    "limit" : 20,
    "next" : "https://api.spotify.com/v1/browse/new-releases?country=SE&offset=20&limit=20",
    "offset" : 0,
    "previous" : null,
    "total" : 500
  }
}
```

<br>

## Get Recommendations

> 아티스트, 트랙 및 장르 기반의 재생 목록 스타일의 음원 추천

<br>

### Endpoints
---
```
GET https://api.spotify.com/v1/recommendations
```

<br>

### Request Parameters

**Header Fields**

- `Authorization` : (필수), `Spotify` 서비스에 접근하기 위한 유효한 토큰

<br>

### Query Parameters

- `limit` : 추천 트랙의 사이즈 제한

- `seed_artists` : 아티스트 명을 ',' 로 분리하여 제공

- `seed_genres` : 장르 명을 ',' 로 분리하여 제공

- `seed_tracks` : 트랙 명을 ',' 로 분리하여 제공

<br>

### Tuneable Track attributes

- `accousticness` : `confidence`를 0.0~1.0 까지 측정

- `danceability` : `danceability`를 0.0~1.0 까지 측정

- `duration_ms` : 트랙의 지속 시간을 ms초 단위로 반환

- `energy` : 에너지 값을 0.0~1.0 까지 측정

- `instrumentainess` : 트랙의 보컬 여부를 0.0~1.0 까지 측정

- `key` : 트랙의 피치를 정수값으로 측정

- `liveness` : 음원에서 청중의 소리를 0.0~1.0 까지 측정

- `loudness` : 트랙의 전체 음량 측정

- `popularity` : 음원의 대중성을 0~100까지 측정

```json
{
  "tracks": [
    {
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/134GdR5tUtxJrf8cpsfpyY"
        },
          "href" : "https://api.spotify.com/v1/artists/134GdR5tUtxJrf8cpsfpyY",
          "id" : "134GdR5tUtxJrf8cpsfpyY",
          "name" : "Elliphant",
          "type" : "artist",
          "uri" : "spotify:artist:134GdR5tUtxJrf8cpsfpyY"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/1D2oK3cJRq97OXDzu77BFR"
        },
          "href" : "https://api.spotify.com/v1/artists/1D2oK3cJRq97OXDzu77BFR",
          "id" : "1D2oK3cJRq97OXDzu77BFR",
          "name" : "Ras Fraser Jr.",
          "type" : "artist",
          "uri" : "spotify:artist:1D2oK3cJRq97OXDzu77BFR"
      } ],
      "disc_number" : 1,
      "duration_ms" : 199133,
      "explicit" : false,
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/1TKYPzH66GwsqyJFKFkBHQ"
      },
      "href" : "https://api.spotify.com/v1/tracks/1TKYPzH66GwsqyJFKFkBHQ",
      "id" : "1TKYPzH66GwsqyJFKFkBHQ",
      "is_playable" : true,
      "name" : "Music Is Life",
      "preview_url" : "https://p.scdn.co/mp3-preview/546099103387186dfe16743a33edd77e52cec738",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:1TKYPzH66GwsqyJFKFkBHQ"
    }, {
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/1VBflYyxBhnDc9uVib98rw"
        },
          "href" : "https://api.spotify.com/v1/artists/1VBflYyxBhnDc9uVib98rw",
          "id" : "1VBflYyxBhnDc9uVib98rw",
          "name" : "Icona Pop",
          "type" : "artist",
          "uri" : "spotify:artist:1VBflYyxBhnDc9uVib98rw"
      } ],
        "disc_number" : 1,
        "duration_ms" : 187026,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/15iosIuxC3C53BgsM5Uggs"
        },
        "href" : "https://api.spotify.com/v1/tracks/15iosIuxC3C53BgsM5Uggs",
        "id" : "15iosIuxC3C53BgsM5Uggs",
        "is_playable" : true,
        "name" : "All Night",
        "preview_url" : "https://p.scdn.co/mp3-preview/9ee589fa7fe4e96bad3483c20b3405fb59776424",
        "track_number" : 2,
        "type" : "track",
        "uri" : "spotify:track:15iosIuxC3C53BgsM5Uggs"
    },
    ...
  ],
  "seeds": [
    {
      "initialPoolSize": 500,
      "afterFilteringSize": 380,
      "afterRelinkingSize": 365,
      "href": "https://api.spotify.com/v1/artists/4NHQUGzhtTLFvgF5SZesLK",
      "id": "4NHQUGzhtTLFvgF5SZesLK",
      "type": "artist"
    }, {
      "initialPoolSize": 250,
      "afterFilteringSize": 172,
      "afterRelinkingSize": 144,
      "href": "https://api.spotify.com/v1/tracks/0c6xIDDpzE81m2q797ordA",
      "id": "0c6xIDDpzE81m2q797ordA",
      "type": "track"
    }
  ]
}
```