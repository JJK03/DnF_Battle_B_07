```mermaid
graph TD
    플레이어((플레이어))

    UC_캐릭터생성["캐릭터생성"]
    UC_몬스터공격["몬스터공격"]
    UC_플레이어체크["플레이어체크"]

    플레이어 --> UC_캐릭터생성
    플레이어 --> UC_몬스터공격

    UC_캐릭터생성 -.->|&lt;&lt;include&gt;&gt;| UC_플레이어체크
    UC_몬스터공격 -.->|&lt;&lt;include&gt;&gt;| UC_플레이어체크