package com.trifork.itb.plugin;

/**
 * Tries the first resolver and falls back to the second only when the first has no usable answer.
 * With the embedded set first, everything it holds is answered offline and reproducibly, and only
 * other references cost a request.
 *
 * <p>When neither finds the QFDD, the combined answer is the least certain of the two: a resolver
 * that was unavailable or ambiguous prevents "not found" from being claimed.
 */
final class CombinedQfddResolver implements QfddResolver {

    private final QfddResolver first;
    private final QfddResolver second;

    CombinedQfddResolver(QfddResolver first, QfddResolver second) {
        this.first = first;
        this.second = second;
    }

    @Override
    public QfddLookup resolve(String id, String version) {
        QfddLookup primary = first.resolve(id, version);
        if (primary.status == QfddLookup.Status.FOUND) {
            return primary;
        }
        QfddLookup secondary = second.resolve(id, version);
        if (secondary.status == QfddLookup.Status.FOUND) {
            return secondary;
        }
        String detail = primary.detail + "; " + secondary.detail;
        if (primary.status == QfddLookup.Status.UNAVAILABLE
                || secondary.status == QfddLookup.Status.UNAVAILABLE) {
            return QfddLookup.unavailable(detail);
        }
        if (primary.status == QfddLookup.Status.AMBIGUOUS
                || secondary.status == QfddLookup.Status.AMBIGUOUS) {
            return QfddLookup.ambiguous(detail);
        }
        return QfddLookup.notFound(detail);
    }
}
