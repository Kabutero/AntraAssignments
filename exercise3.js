function checkEmailId(str) {
    if(str.indexOf('@') < str.indexOf('.'))
    {
        if(str.indexOf('@') < str.indexOf('.') - 1)
        {
            return true;
        }
    }
    return false;
}