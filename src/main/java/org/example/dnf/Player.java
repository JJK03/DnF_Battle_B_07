package org.example.dnf;

public class Player {
    private final String id;
    private final String characterName;
    private final String job;
    private final int level;
    private final int hp;
    private final int attackPower;
    private final String damageType;

    public Player(String id, String characterName, String job, int level) {
        this.id = id;
        this.characterName = characterName;
        this.job = job;
        this.level = level;

        if ("전사".equals(job)) {
            this.hp = level * 100;
            this.attackPower = level * 15;
            this.damageType = "물리데미지";
        } else {
            this.hp = level * 60;
            this.attackPower = level * 25;
            this.damageType = "마법데미지";
        }
    }

    public String getId() {
        return id;
    }

    public String getCharacterName() {
        return characterName;
    }

    public String getJob() {
        return job;
    }

    public int getLevel() {
        return level;
    }

    public int getHp() {
        return hp;
    }

    public int getAttackPower() {
        return attackPower;
    }

    public String getDamageType() {
        return damageType;
    }
}
