```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어
    participant UI as Create_Character_UI
    participant Battle as 전투
    participant P_Class as 플레이어 클래스
    participant Char as 캐릭터 (전사/마법사)

    Player->>UI: 캐릭터 생성 입력 (플레이어id="hero", 캐릭터명, 직업, 레벨)
    UI->>Battle: 캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨)
    
    %% <<include>> 플레이어체크 반영
    rect rgb(240, 240, 240)
        Note over Battle, P_Class: [Include] 플레이어 검증 수행
        Battle->>P_Class: 플레이어체크(플레이어id)
        P_Class-->>Battle: boolean (true)
    end

    Note over Battle: [직업별 능력치 계산 공식]<br/>전사: HP=레벨*100, 공격력=레벨*15<br/>마법사: HP=레벨*60, 공격력=레벨*25
    
    Battle->>Char: 객체 생성 및 데이터 세팅 (-캐릭터명, -레벨, -HP, -공격력)
    Char-->>Battle: 생성 완료
    Battle-->>UI: void (처리 완료)
    UI-->>Player: 캐릭터 생성 결과 출력 (JSP)