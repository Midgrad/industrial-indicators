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

function floor125(x)
{
    if (x === 0.0)
        return 0.0;

    var sign = (x > 0) ? 1.0 : -1.0;
    var lx = Math.log10(Math.abs(x));
    var p10 = Math.floor(lx);

    var fr = Math.pow(10.0, lx - p10);
    if (fr >= 10.0)
        fr = 10.0;
    else if (fr >= 5.0)
        fr = 5.0;
    else if (fr >= 2.0)
        fr = 2.0;
    else
        fr = 1.0;

    console.log(sign, lx, p10)

    return sign * fr * Math.pow(10.0, p10);
}

function ceil125(x)
{
    if (x === 0.0)
        return 0.0;

    var sign = (x > 0) ? 1.0 : -1.0;
    var lx = Math.log10(Math.abs(x));
    var p10 = Math.floor(lx);

    var fr = Math.pow(10.0, lx - p10);
    if (fr <= 1.0)
        fr = 1.0;
    else if (fr <= 2.0)
        fr = 2.0;
    else if (fr <= 5.0)
        fr = 5.0;
    else
        fr = 10.0;

    return sign * fr * Math.pow(10.0, p10);
}
