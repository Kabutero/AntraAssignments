function validateCards(str1, str2)
{
    var isValid = false;
    var isAllowed = true;
    foreach(item in str2)
    {
        if(str1.indexOf(item) == 0)
        {
            isAllowed = false;
        }
    }
    var checkLast = str1.pop();
    var checkSum = 0;
    foreach(item in str1)
    {
        checkSum = checkSum + (item * 2);
    }
    str1.push(checkSum);
    if(checkSum % 10 == checkLast)
    {
        isValid = true;
    }

    let creditCard = {
        
            str1,
            isValid,
            isAllowed
        
    }
}

