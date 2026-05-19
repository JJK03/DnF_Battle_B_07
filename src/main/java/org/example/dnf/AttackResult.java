package org.example.dnf;

public class AttackResult {
    private final String skillName;
    private final double damage;
    private final String grade;

    public AttackResult(String skillName, double damage, String grade) {
        this.skillName = skillName;
        this.damage = damage;
        this.grade = grade;
    }

    public String getSkillName() {
        return skillName;
    }

    public double getDamage() {
        return damage;
    }

    public String getGrade() {
        return grade;
    }
}
