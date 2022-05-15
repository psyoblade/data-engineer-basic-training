---
description: >-
  문자열은 텍스트와 바이트 기반의 데이터를 표현하기 위한 문자열의 콜렉션입니다. 파이썬 문자열은 기본적으로 **불변 시퀀스** 유형으로 분류됩니다. 즉, 문자열에 포함된 데이터는 변경이 불가능하며, 위치정보를 가진다는 의미입니다.
  
---


# 문자열
> 하나 하나의 문자열의 연속적인 나열로 표현되므로 *시퀀스*라고 부르기도 합니다. 이러한 문자(바이트)의 시퀀스의 특성에 따른 다양한 동작을 지원하는데 길이를 알아내거나, 위치(인덱스)를 기준으로 문자열을 조작하는 것등이 있습니다


## 1. 문자열 제공 함수

| 리터럴 | 해석 |
| --- | --- |
| '줄바꿈\n탭\t' | 특수문자를 표현하기 위한 역슬래시 문자열 표현식 ('\t':탭, '\n':줄바꿈) |
| """ """ | 삼중 인용부호 문자열 (멀티라인, 홑/쌍따옴표 모두 허용) |
| + | 문자열 붙임 (concat) |
| * | 문자열 반복 |
| str[i] | 문자열 위치 반환 (indexing) |
| str[0:4] | 문자열 잘라내기 (slicing) |
| len(str) | 문자열 길이 |
| str.find(term) | str 에서 term 을 탐색 |
| str.split(term) | term 기준으로 문자열을 쪼개기 |
| strip, rstrip, lstrip | 공백 제거 |
| replace(x, y) | 문자열 내에서 x를 y로 교체 |
| upper, lower | 대문자, 소문자로 변경 |
| startswith(term), endswith(term) | term 으로 시작 혹은 종료되는지 여부 |
| deli.join(list) | 문자열을 deli를 이용하여 결합 |
| encode, decode | 문자열을 지정한 유형으로 인코딩, 디코딩 |
| for x in str | 반복문 |
| x in str | 문자열 내에 존재하는지 여부 (멤버십) |
| map(func, str) | 반복 후 반환 |
| re.match(regex, str) | 문자열이 정규식에 매칭 |


### 1-1. 문자열 길이
```python
str_1 = "문자열의길이"
print(len(str_1))
print(str_1[0])
```

### 1-2. 시퀀스 연산
```python
# 문자열[인덱스]
str_2 = "한글은ABC123X"
print(str_2[0])
print(str_2[3])
print(str_2[6])
print(str_2[-1])
print(str_2[len(str_2)-1])
```

### 1-3. 슬라이싱 연산
```python
# 문자열[인덱스:인덱스]
#        012345678901234567
str_3 = "HELLO_PYTHON_WORLD"
print(str_3[6:12])
print(str_3[13:])
print(str_3[:12])
print(str_3[:])
print(str_3[:-1])
```

### 1-4. 문자열 붙이기
```python
# 문자열 + 문자열
print("HELLO" + "_" + "PYTHON" + "_" + "WORLD")
```

### 1-5. 문자열 반복하기
```python
# 문자열 * 숫자
print("HELLO"*3)
```

### 1-6. 문자열 위치찾기
```python
# 문자열.find("찾을문자열") 
print("HELLO_PYTHON_WORLD".find("PYTHON"))
```

### 1-7. 문자열 치환하기
```python
# 문자열.replace("찾을문자열", "변경할문자열")
print("HELLO_PYTHON_WORLD".replace("PYTHON", "NOHTYP"))
```

### 1-8. 문자열 쪼개기
```python
# 문자열.split("쪼갤문자열")
print("HELLO_PYTHON_WORLD".split("_"))
```

### 1-9. 문자열 포맷팅
```python
# "포맷팅".format(...)
print("{:.2f}".format(1111111/3))
print("%0.2f" % (1111111/3))
```

### 1-10. 기타 함수
```python
# upper(), lower(), isalpha(), isalnum(), replace(), lstrip(), rstrip(), strip(), upper(), lower(), join()
# capatalize(), ljust(), rjust(), center()
say_hello=" Hello Python3 World !! "
say_hello.upper()
say_hello.lower()
say_hello.isalpha()
say_hello.isalnum()
say_hello.replace('Python', 'PYTHON')
say_hello.lstrip()
say_hello.rstrip()
say_hello.strip()
say_hello.strip().capitalize()

lower_say_hello=say_hello.lower()
print(" ".join(term.capitalize() for term in lower_say_hello.strip().split()))

items = say_hello.strip().split(" ")
print("_".join(items))

say_hello.center(50)
say_hello.ljust(50, '_')
say_hello.rjust(50, '_')
```

### 1-11. 문자열 다루기
```python
print("'string'")
print('"string"')
print("""
아주 긴 문장을 작성할 경우에 "쌍따옴표", '홑따옴표' 모두 사용할 수 있습니다
이렇게 작성하면 됩니다
특수문자는 역슬래시\n를 넣으면\t됩니다.
""")

파이썬 str 문자열은 유니코드 텍스트로 처리되며, 메모리 상에서는 1, 2 또는 4바이트로 저장됩니다
str_4 = bytes('한글은', 'utf-8')
print(len(str_4))

str_5 = bytes('abc', 'utf-8')
print(len(str_5))

str_6 = bytes('a한', 'utf-8')
print(len(str_6))
```

## 2. 문자열의 실제 동작

> 앞서 얘기한 대로 문자열은 불변 객체이므로 모든 문자열 연산에 있어서 항상 새로운 문자열 객체가 생성되는 것이며 `str * 4`과 같은 연산은 `str + str + str + str` 와 동일한 연결을 반복하는 것입니다. 의외로 쓸모없는 메소드 같지만, 콘솔 출력에서 출력을 구분하기 위해 80개 문자열 가로줄을 출력하는 예제에서는 훌륭하게 사용되기도 합니다. `print('='*80)`

* 문자열 `PYTHON!` 뜯어보기
```bash
# str = "PYTHON!"
0    1    2             -2   -1
↓    ↓    ↓              ↓    ↓
┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐
│ P ││ Y ││ T ││ H ││ O ││ N ││ ! │
└───┘└───┘└───┘└───┘└───┘└───┘└───┘
↑                                 ↑
[:                               :]
```

### 2-1. 슬라이싱 (Slicing)

* 문자열의 시작과 끝은 아래와 같은 형식으로 잘래낼 수 있습니다

```python
len(str)   # -> 7
str[0:2]   # -> PY
str[-1:]   # -> !
str[-3:-1] # -> ON
str[0:-1]  # -> PYTHON
str[:]     # -> PYTHON!
str[0]     # -> O
str[7-1]   # -> !
```

### 2-2. 확장슬라이싱 (Extended Slicing)

* 문자열[start:end:step] 으로 스텝을 통해 뛰어넘거나, 뒤집기(음수간격)가 가능

```python
str[0:7:2] # -> PTO!
str[::2]   # -> PTO!
str[::-1]  # -> !NOHTYP
```

### 2-3. 문자열 변환 도구

* 숫자형 문자를 숫자로 변경 (Casting)

```python
int('1234')
float('3.141592')
str(1234)
```

* 문자코드 변환 (ASCII <-> Ordinal )

```python
ord('A')              # -> 65
chr(65)               # -> 'A'

chr(ord('A')+25)      # -> Z
ord('Z')-ord('A')+1   # -> 26
```


## 3. 문자열 포맷팅

> 문자열을 임의의 포맷을 정의해 두고, 데이터를 제공하여 최종 원하는 문자열 포맷을 구성하는 표현식입니다. 예를 들어 `str = "나의 이름은%s 이고, 나이는 %d입니다." % (my_name, my_age)` 와 같은 방식입니다.


* '%'에 매칭되는 코드의 의미
  - 상세 포맷 : `%[(code)][flags][width][.precision]typecode`

| 코드 | 의미 |
| --- | --- |
| s | 문자열 |
| d | 정수형 숫자 |
| e | 부동소수점 표기법 |
| f | 실수형 숫자 |
| % | 리터럴 (%) |


### 3-1. 원주율(3.141592...)을 소수점 2자리까지만 표현
```python
"%.2f" % math.pi
```

### 3-2. 최대 8자리수로 표현하되 빈자리는 0으로 채우도록 표현
```python
"%08d" % 1234
```

### 3-3. 원주율(math.pi)를 부동소수점 표기법으로 소수점 4자리까지 표현
```python
"%.4e" % math.pi
```

### 3-4. 위치에 따른 표기법
```python
'{0}, {1} and {2}'.format('park', 'suhyuk', 28)
'{last}, {first} and {age}'.format(last='park', first='suhyuk', age=29)
'{}, {} and {}'.format('park', 'suhyuk', 30)
```

### 3-5. 고급 포맷팅 예제 (Python3.6>=)
* `[[fill]align][sign][#][0][width][,][.precision][typecode]`
  - {0:>10} : 첫 번째 값을 우측정렬, 10자리 출력
  - {1:10.4f} : 두 번째 값을 10자리, 소수점 4자리, 부동소수점 출력
  - {2:,d} : 세 번째 숫자값을 자릿수 콤마를 찍어서 출력

```python
'{0:>10} = {1:10.4f}'.format('python', math.pi)
'{0:e} = {1:10.4f}'.format('python', math.pi)
'{0:,d}'.format(123456789)
```
