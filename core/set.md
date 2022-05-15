---
description: >-
  수학적 집합의 정의에 해당하는 연산을 지원하고, *중복되지 않으*며, 불변한 객체들의 *정렬되지 않은* 컬렉션을 말합니다. 동일한 아이템은 반복 추가되는 것과 무관하게 한 번만 나타납니다. 특히 중복을 쉽게 제거할 수 있다는 장점이 있습니다. 
---


# 집합

## 1. 집합 연산


### 1-1. 집합 간의 연산

| 연산자 | 설명 |
| --- | --- |
| - | 차집합 |
| \| | 합집합 |
| & | 교집합 |
| ^ | 대칭 차집합 (XOR) |
| >, < | 포함집합, 부분집합 |
| x in set | 집합에 x 가 포함되었는지 여부 (멤버십) |

### 1-2. 집합 연산자

| 연산자 | 설명 |
| --- | --- |
| setX.add(x) | 아이템 x 추가 |
| setX.remove(x) | 아이템 x 제거 |
| setX.update(setY) | setX 을 setY 와 병합 (return None) |
| setX.intersection(setY) | setX & setY 와 동일함 (교집합) |
| setX.union(setY) | setX | setY 와 동일함 (합집합) |
| setX.issubset(setY) | setY 가 setX 의 부분집합인지 여부 |

```python
# 집합
set_1=set("소주 만 병만 주소")
print(set_1)

set_2={"소","주"}
print(set_2)

set_3 = set_1 - set_2 - {" "}
print(set_3)

set_4 = set_1 & set_2
print(set_4)

set_5 = set_1 | {"!"}
print(set_5)

print(set_1 > set_2, set_2 > set_1)

print(set_1 ^ set_2)

print(set_1.union(set_2))
set_1.update(set_2)
print(set_1)

print(set_2.issubset(set_1))
```

### 1-3. 집합의 불변제약

* 집합의 경우 포함된 객체의 내부가 변경되는 경우 구현에 문제가 있을 수 있으므로, 집합은 불변(immutable)객체 타입만 포함할 수 있으며, 리스트 및 딕셔너리는 저장할 수 없습니다. 대신 튜플(immutable)은 저장가능하지만, 전체 값을 비교하게 됩니다.

```python
set_6 = {1.23}
set_6.add([1,2,3])
set_6.add({'a':'1})
set_6.add((1,2,3))
```


### 1-4. 집합 컴프리헨션

* 반복 객체를 통해 임의의 표현식을 통해 새로운 집합을 만들어내는 표현식을 말합니다.
  - `{ 표현식 for 아이템 in 반복객체 }` 와 같은 형식으로 구성합니다
  - 즉, 반복객체(리스트 등)의 개별 아이템에 대해 임의의 표현식을 수행한 결과를 집합으로 생성합니다

```python
{ x ** 2 for x in range(0, 9) }
{ x ** 2 for x in [1,2,3,4,5] if x % 2 == 0 }
```


