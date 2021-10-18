let salaries = {
    John:100,
    Ann:160,
    Pete:130
}

let employees = [{
    name: 'John',
    salary: '100'
},
{
    name: 'Ann',
    salary: 160
},
{
    name:'Pete',
    salary: 130
}]

var sum;

let sum = 0;

let length = employees.length;
for(i = 0; i < length; i++)
{
    sum += employees[i].salary;
}
console.log(sum);