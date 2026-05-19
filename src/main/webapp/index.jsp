<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.dnf.AttackResult" %>
<%@ page import="org.example.dnf.CharacterCreator" %>
<%@ page import="org.example.dnf.MonsterAttack" %>
<%@ page import="org.example.dnf.Player" %>
<%!
    private String escape(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    Player player = null;
    AttackResult attackResult = null;
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        String characterName = request.getParameter("characterName");
        String job = request.getParameter("job");
        int level = Integer.parseInt(request.getParameter("level"));

        CharacterCreator creator = new CharacterCreator();
        player = creator.create(id, characterName, job, level);

        if (player == null) {
            message = "플레이어 체크 실패: id는 hero만 통과할 수 있습니다.";
        } else if ("attack".equals(action)) {
            MonsterAttack monsterAttack = new MonsterAttack();
            attackResult = monsterAttack.attack(player);
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>DnF Mini RPG</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            margin: 0;
            color: #f7ead0;
            font-family: "Malgun Gothic", "Segoe UI", sans-serif;
            background:
                    radial-gradient(circle at top left, rgba(160, 31, 31, 0.26), transparent 34rem),
                    linear-gradient(135deg, rgba(255, 255, 255, 0.04) 0 1px, transparent 1px 14px),
                    #14110f;
        }

        .page {
            width: min(1060px, calc(100% - 32px));
            min-height: 100vh;
            margin: 0 auto;
            padding: 44px 0;
            display: grid;
            align-items: center;
        }

        .rpg-frame {
            border: 1px solid #7e6036;
            background:
                    linear-gradient(180deg, rgba(72, 48, 31, 0.94), rgba(24, 21, 19, 0.98)),
                    #1f1a17;
            box-shadow: 0 28px 80px rgba(0, 0, 0, 0.48);
        }

        .top-bar {
            min-height: 82px;
            padding: 20px 26px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            border-bottom: 1px solid rgba(235, 184, 94, 0.32);
            background: linear-gradient(90deg, rgba(120, 31, 28, 0.62), rgba(31, 30, 25, 0.76));
        }

        .brand {
            margin: 0;
            color: #ffd987;
            font-size: 30px;
            font-weight: 800;
        }

        .chapter {
            min-width: 146px;
            padding: 10px 14px;
            border: 1px solid rgba(255, 217, 135, 0.46);
            color: #d5f0dd;
            font-size: 13px;
            text-align: center;
            background: rgba(16, 42, 32, 0.74);
        }

        .content {
            display: grid;
            grid-template-columns: minmax(280px, 420px) 1fr;
            gap: 0;
        }

        .create-panel,
        .result-panel {
            padding: 30px;
        }

        .create-panel {
            border-right: 1px solid rgba(235, 184, 94, 0.24);
            background: rgba(13, 11, 10, 0.32);
        }

        .panel-title {
            margin: 0 0 22px;
            color: #fff6df;
            font-size: 22px;
        }

        .field {
            margin: 0 0 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #d9c6a0;
            font-size: 13px;
            font-weight: 700;
        }

        input,
        select {
            width: 100%;
            min-height: 46px;
            border: 1px solid #745638;
            padding: 0 13px;
            color: #fff7e7;
            font: inherit;
            background: #201b17;
            outline: none;
        }

        input:focus,
        select:focus {
            border-color: #ffd987;
            box-shadow: 0 0 0 3px rgba(255, 217, 135, 0.18);
        }

        button {
            width: 100%;
            min-height: 50px;
            margin-top: 8px;
            border: 1px solid #ffd987;
            color: #2a1512;
            font: inherit;
            font-weight: 800;
            cursor: pointer;
            background: linear-gradient(180deg, #ffe29b, #d78b33);
        }

        button:hover {
            filter: brightness(1.07);
        }

        .message {
            margin: 0 0 18px;
            padding: 14px 16px;
            border: 1px solid rgba(255, 128, 128, 0.56);
            color: #ffd3d3;
            background: rgba(104, 22, 22, 0.46);
        }

        .empty-state {
            min-height: 100%;
            display: grid;
            align-content: center;
            gap: 18px;
        }

        .crest {
            width: min(280px, 100%);
            aspect-ratio: 1;
            display: grid;
            place-items: center;
            border: 1px solid rgba(255, 217, 135, 0.38);
            background:
                    linear-gradient(45deg, transparent 45%, rgba(255, 217, 135, 0.42) 46% 54%, transparent 55%),
                    linear-gradient(-45deg, transparent 45%, rgba(151, 36, 34, 0.62) 46% 54%, transparent 55%),
                    radial-gradient(circle, rgba(18, 84, 52, 0.82), rgba(21, 18, 16, 0.94) 62%);
        }

        .crest span {
            width: 86px;
            height: 86px;
            border: 2px solid #ffd987;
            transform: rotate(45deg);
            background: rgba(15, 12, 11, 0.56);
        }

        .hint {
            max-width: 390px;
            margin: 0;
            color: #bba980;
            line-height: 1.7;
        }

        .character-card {
            max-width: 520px;
        }

        .summary h2 {
            margin: 0 0 6px;
            color: #fff4d7;
            font-size: 28px;
        }

        .summary .job {
            margin: 0 0 22px;
            color: #8ee4aa;
            font-weight: 700;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
            margin: 0;
        }

        .stat {
            min-height: 74px;
            padding: 13px 14px;
            border: 1px solid rgba(235, 184, 94, 0.28);
            background: rgba(255, 255, 255, 0.045);
        }

        .stat strong {
            display: block;
            color: #bda77a;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .stat span {
            color: #fff7e7;
            font-size: 20px;
            font-weight: 800;
        }

        .battle-panel {
            padding: 30px;
            border-top: 1px solid rgba(235, 184, 94, 0.24);
            background: rgba(7, 11, 13, 0.35);
        }

        .battle-title {
            margin: 0 0 18px;
            color: #fff6df;
            font-size: 22px;
        }

        .battle-stage {
            position: relative;
            min-height: 260px;
            overflow: hidden;
            border: 1px solid rgba(235, 184, 94, 0.28);
            background:
                    linear-gradient(180deg, rgba(20, 20, 24, 0.3), rgba(0, 0, 0, 0.44)),
                    repeating-linear-gradient(90deg, rgba(255, 255, 255, 0.035) 0 1px, transparent 1px 38px),
                    #191514;
        }

        .battle-floor {
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;
            height: 74px;
            border-top: 1px solid rgba(255, 217, 135, 0.16);
            background: linear-gradient(180deg, rgba(84, 58, 38, 0.42), rgba(26, 20, 17, 0.9));
        }

        .battle-sprite {
            position: absolute;
            z-index: 2;
            object-fit: contain;
            image-rendering: pixelated;
            image-rendering: crisp-edges;
            user-select: none;
            pointer-events: none;
        }

        .hero-sprite {
            left: 7%;
            bottom: 28px;
            width: clamp(112px, 18vw, 170px);
        }

        .monster-sprite {
            right: 6%;
            bottom: 22px;
            width: clamp(150px, 24vw, 230px);
        }

        .fireball-sprite {
            left: 27%;
            bottom: 116px;
            width: clamp(54px, 8vw, 82px);
            opacity: 0;
        }

        .battle-stage.warrior-attack .hero-sprite {
            animation: warriorStrike 0.75s ease-out;
        }

        .battle-stage.mage-attack .fireball-sprite {
            animation: fireballCast 0.95s ease-out forwards;
        }

        .battle-stage.is-attacking .monster-sprite {
            animation: monsterHit 0.42s ease-out 0.58s;
        }

        .skill-form {
            margin: 18px 0 0;
            max-width: 280px;
        }

        .attack-result {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 12px;
            margin-top: 18px;
        }

        .attack-result .stat {
            background: rgba(72, 24, 18, 0.34);
        }

        @keyframes warriorStrike {
            0% {
                transform: translateX(0);
            }
            45% {
                transform: translateX(92px);
            }
            100% {
                transform: translateX(0);
            }
        }

        @keyframes fireballCast {
            0% {
                opacity: 0;
                transform: translateX(0) scale(0.75);
            }
            18% {
                opacity: 1;
            }
            90% {
                opacity: 1;
                transform: translateX(330px) scale(1);
            }
            100% {
                opacity: 0;
                transform: translateX(330px) scale(0.85);
            }
        }

        @keyframes monsterHit {
            0% {
                transform: translateX(0);
                filter: brightness(1);
            }
            45% {
                transform: translateX(14px);
                filter: brightness(1.7);
            }
            100% {
                transform: translateX(0);
                filter: brightness(1);
            }
        }

        @media (max-width: 760px) {
            .page {
                width: min(100% - 20px, 520px);
                padding: 20px 0;
            }

            .top-bar,
            .content,
            .stats {
                grid-template-columns: 1fr;
            }

            .top-bar {
                align-items: stretch;
                flex-direction: column;
            }

            .brand {
                font-size: 25px;
            }

            .create-panel {
                border-right: 0;
                border-bottom: 1px solid rgba(235, 184, 94, 0.24);
            }

            .create-panel,
            .result-panel {
                padding: 22px;
            }

            .battle-panel {
                padding: 22px;
            }

            .battle-stage {
                min-height: 230px;
            }

            .hero-sprite {
                left: 3%;
                width: 112px;
            }

            .monster-sprite {
                right: 2%;
                width: 150px;
            }

            .fireball-sprite {
                left: 27%;
                width: 56px;
            }

            .attack-result {
                grid-template-columns: 1fr;
            }

            @keyframes warriorStrike {
                0% {
                    transform: translateX(0);
                }
                45% {
                    transform: translateX(52px);
                }
                100% {
                    transform: translateX(0);
                }
            }

            @keyframes fireballCast {
                0% {
                    opacity: 0;
                    transform: translateX(0) scale(0.75);
                }
                18% {
                    opacity: 1;
                }
                90% {
                    opacity: 1;
                    transform: translateX(142px) scale(1);
                }
                100% {
                    opacity: 0;
                    transform: translateX(142px) scale(0.85);
                }
            }
        }
    </style>
</head>
<body>
<main class="page">
    <section class="rpg-frame">
        <header class="top-bar">
            <h1 class="brand">DnF Mini RPG</h1>
            <div class="chapter">CHARACTER CREATE</div>
        </header>

        <div class="content">
            <section class="create-panel">
                <h2 class="panel-title">캐릭터 생성</h2>

                <form method="post">
                    <input type="hidden" name="action" value="create">
                    <p class="field">
                        <label for="id">플레이어 ID</label>
                        <input type="text" id="id" name="id" required>
                    </p>
                    <p class="field">
                        <label for="characterName">캐릭터 명</label>
                        <input type="text" id="characterName" name="characterName" required>
                    </p>
                    <p class="field">
                        <label for="job">직업</label>
                        <select id="job" name="job" required>
                            <option value="전사">전사</option>
                            <option value="마법사">마법사</option>
                        </select>
                    </p>
                    <p class="field">
                        <label for="level">레벨</label>
                        <input type="number" id="level" name="level" min="1" required>
                    </p>
                    <button type="submit">생성</button>
                </form>
            </section>

            <section class="result-panel">
                <% if (message != null) { %>
                    <p class="message"><%= message %></p>
                <% } %>

                <% if (player != null) { %>
                    <div class="character-card">
                        <div class="summary">
                            <h2><%= escape(player.getCharacterName()) %></h2>
                            <p class="job"><%= escape(player.getJob()) %></p>

                            <div class="stats">
                                <div class="stat">
                                    <strong>ID</strong>
                                    <span><%= escape(player.getId()) %></span>
                                </div>
                                <div class="stat">
                                    <strong>LEVEL</strong>
                                    <span><%= player.getLevel() %></span>
                                </div>
                                <div class="stat">
                                    <strong>HP</strong>
                                    <span><%= player.getHp() %></span>
                                </div>
                                <div class="stat">
                                    <strong>ATTACK</strong>
                                    <span><%= player.getAttackPower() %> <%= escape(player.getDamageType()) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    <div class="empty-state">
                        <div class="crest"><span></span></div>
                        <p class="hint">던전에 입장할 캐릭터 정보를 입력하면 이곳에 생성 결과가 표시됩니다.</p>
                    </div>
                <% } %>
            </section>
        </div>

        <% if (player != null) { %>
            <section class="battle-panel">
                <h2 class="battle-title">몬스터 전투</h2>

                <div class="battle-stage <%= attackResult != null ? "is-attacking" : "" %> <%= attackResult != null && "전사".equals(player.getJob()) ? "warrior-attack" : "" %> <%= attackResult != null && "마법사".equals(player.getJob()) ? "mage-attack" : "" %>">
                    <div class="battle-floor"></div>
                    <img class="battle-sprite hero-sprite"
                         src="<%= request.getContextPath() %>/assets/<%= "전사".equals(player.getJob()) ? "warrior-sprite.png" : "mage-sprite.png" %>"
                         alt="<%= escape(player.getJob()) %>">
                    <img class="battle-sprite fireball-sprite"
                         src="<%= request.getContextPath() %>/assets/fireball-sprite.png"
                         alt="파이어볼">
                    <img class="battle-sprite monster-sprite"
                         src="<%= request.getContextPath() %>/assets/dragon-sprite.png"
                         alt="드래곤 몬스터">
                </div>

                <form method="post" class="skill-form">
                    <input type="hidden" name="action" value="attack">
                    <input type="hidden" name="id" value="<%= escape(player.getId()) %>">
                    <input type="hidden" name="characterName" value="<%= escape(player.getCharacterName()) %>">
                    <input type="hidden" name="job" value="<%= escape(player.getJob()) %>">
                    <input type="hidden" name="level" value="<%= player.getLevel() %>">
                    <button type="submit"><%= "전사".equals(player.getJob()) ? "검 휘두르기!" : "파이어볼!" %></button>
                </form>

                <% if (attackResult != null) { %>
                    <div class="attack-result">
                        <div class="stat">
                            <strong>SKILL</strong>
                            <span><%= escape(attackResult.getSkillName()) %></span>
                        </div>
                        <div class="stat">
                            <strong>DAMAGE</strong>
                            <span><%= attackResult.getDamage() %></span>
                        </div>
                        <div class="stat">
                            <strong>GRADE</strong>
                            <span><%= escape(attackResult.getGrade()) %></span>
                        </div>
                    </div>
                <% } %>
            </section>
        <% } %>
    </section>
</main>
</body>
</html>
