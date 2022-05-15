---
description: >-
  현실 세계의 복잡한 문제를 해결하기 위해서는 다양한 데이터 유형을 활용하여 문제를 표현하고 이를 해결하는 방법을 학습합니다
---


# 파이썬 자료형

## 파이썬의 계층 구조
> 파이썬 프로그램은 모듈(.py)로 구성되어 있고, 각 모듈은 구문(statment)를 포함하고 있으며, 구문은 표현식(expression)을 포함하고 있고, 각 표현은 객체(object)를 만들고 처리합니다. 


### 1. 파이썬 예제 프로그램

```python
# favorite.py
favorite_words = [ "파이썬", "봄", "가을", "프로그래밍" ]
word = "파이썬"

if word in favorite_words:
    print("'" + word + "'는 내가 좋아하는 단어입니다")
```

### 2. 모듈 > 구문 > 표현식 > 객체
```python
# favorite.py  # <-- 모듈
favorite_words = [ "파이썬", "봄", "가을", "프로그래밍" ] # <-- 구문
word = "파이썬"

if word in favorite_words: # <-- 표현식 returns True (객체)
    print("'" + word + "'는 내가 좋아하는 단어입니다")
```

### 3. 핵심 데이터 타입

* 데이터 타입 별 객체의 표현
| 객체 타입 | 리터럴 |
| --- | --- |
| 숫자 | 1234, 3.14, 3+4j |
| 문자열 | 'python', "it's me" |
| 리스트 | [1, 2, 3], [1, "two", "셋"] |
| 딕셔너리 | { "food":"spam", "taste":"good"}, { "name":{"last":"park", "first":"suhyuk"}} |
| 튜플 | (1,2,3,4) |
| 파일 | open('untitled.txt') |
| 집합 | {'a', 'b', 'c'} |

> 리터럴(Literal) :객체를 생성하는 표현식을 말하며, 아래와 같이 파이썬의 특정 타입의 데이터를 생성하기 위해 사용한 표현식입니다. 종종 상수(constant)를 의미하기도 하지만 여기서는 다른 의미로 사용되었습니다. 파이썬에는 데이터 타입을 선언해 주지 않기 때문에 이렇게 표현식을 통해 데이터 타입을 결정합니다

#### 3-1. 숫자
```python
num_1 = 1234
num_2 = 3.1415
num_3 = 3 + 4j
num_4 = 0b111
num_5 = Decimal()
num_6 = Fraction()
print(num_1, num_2, num_3, num_4, num_5, num_6)
```

#### 3-2. 문자열
```python
str_1 = 'hello world'  # 
str_2 = "It's Python"
str_3 = b'a\x01c'
str_4 = u'sp\xc4m'
print(str_1, str_2, str_3, str_4)
```

#### 3-3. 리스트
```python
list_1 = [1, [2, 'three'], 4, 5]
list_2 = list(range(10))
print(list_1, list_2)
```


#### 3-4. 딕셔너리
```python
# 한글도 가능하지만, 가능하면 영문으로 작성
dict_1 = {"음식":"빵", "음료":"콜라"}
dict_2 = dict(시간=10)
print(dict_1, dict_2)
```

#### 3-5. 튜플
```python
tuple_1 = (1, 1.5, 'hello', {})
tuple_2 = tuple('튜플_아이템')
tuple_3 = namedtuple('Point', ["x", "y"])
print(tuple_1, tuple_2, tuple_3)
```

#### 3-6. 파일
```python
# 파일은 열었다면 반드시 닫아 주어야 하지만, with 구문을 쓰시면 자동으로 닫힙니다
with open("./untitled.txt", "w+") as file_1: print(file_1.write("hello world"))
with open("./untitled.txt", "r") as file_2: print(file_2.readline())
```

#### 3-7. 집합
```python
set_1 = set("abc")
set_2 = {"하나", "둘", "셋", "하나"}
set_3 = {1, "둘", "three", 4}
print(set_1, set_2, set_3)
```

#### 3-8. 불리언
```python
bool_1 = True
bool_2 = False
print(bool_1, bool_2)
```
