package org.example.dnf;

public class CharacterCreator {
    private static final String PASS_ID = "hero";

    public Player create(String id, String characterName, String job, int level) {
        if (!PASS_ID.equals(id)) {
            return null;
        }

        return new Player(id, characterName, job, level);
    }
}
