package com.trifork.itb.plugin;

/** A single validation finding produced by one of the wrapped engines. */
final class Finding {

    enum Level {
        ERROR,
        WARNING,
        INFO
    }

    final Level level;
    final String description;

    /** Location within the validated file as "line:column", or null when unknown. */
    final String lineLocation;

    /** Rule/assertion identifier, or null. */
    final String assertionId;

    Finding(Level level, String description, String lineLocation, String assertionId) {
        this.level = level;
        this.description = description;
        this.lineLocation = lineLocation;
        this.assertionId = assertionId;
    }
}
