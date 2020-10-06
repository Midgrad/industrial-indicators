.pragma library

function angle180(value) {
    while (value <= -180) value += 360;
    while (value > 180) value -= 360;
    return value;
}

function angle360(value) {
    while (value < 0) value += 360;
    while (value >= 360) value -= 360;
    return value;
}

function mapToRange(value, minValue, maxValue, length) {
    return (value - minValue) / (maxValue - minValue) * length;
}

function mapFromRange(pos, minValue, maxValue, length) {
    return pos / length * (maxValue - minValue) + minValue;
}

