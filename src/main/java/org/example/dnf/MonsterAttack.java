package org.example.dnf;

public class MonsterAttack {
    public AttackResult attack(Player player) {
        String skillName;
        double damage;

        if ("전사".equals(player.getJob())) {
            skillName = "검 휘두르기!";
            damage = player.getAttackPower() * 1.5;
        } else {
            skillName = "파이어볼!";
            damage = player.getAttackPower() * 2.0;
        }

        return new AttackResult(skillName, damage, grade(damage));
    }

    private String grade(double damage) {
        if (damage >= 200) {
            return "S급 공격";
        }

        if (damage >= 100) {
            return "A급 공격";
        }

        return "B급 공격";
    }
}
