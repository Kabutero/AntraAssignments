function truncate(str, maxlength) {
    while(str.length > maxlength)
    {
        str.pop();
    }
    str.push('...');
}