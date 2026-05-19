```mermaid
classDiagram
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }

    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int) void
        +몬스터공격(플레이어id: String) void
    }

    class 플레이어 {
        +플레이어체크(플레이어id: String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        -캐릭터명: String
        -레벨: int
        -HP: int
        -공격력: int
        +스킬발동()* int
    }

    class 전사 {
        +스킬발동_검_휘두르기() int
    }

    class 마법사 {
        +스킬발동_파이어볼() int
    }

    Create_Character_UI ..> 전투 : 사용
    Attack_Monster_UI ..> 전투 : 사용

    전투 ..> 플레이어 : 검증 요청
    전투 --> 캐릭터 : 관리

    캐릭터 <|-- 전사
    캐릭터 <|-- 마법사