

export function daffodilsNumber(): number[]{
  let result: number[] = [];

  for(let i = 100; i < 1000; i++){
    let unitsDigit: number = i % 10;
    let tenthsDigit: number = Math.floor(i / 10) - Math.floor(i / 100) * 10;
    let hundredthsDigit: number = Math.floor(i / 100);

    if(i === unitsDigit**3 + tenthsDigit**3 + hundredthsDigit**3){
      result.push(i);
    }
  }
  return result;
}

export function multiplicationTable(): string[][]{
  let result: string[][] = [];

  for(let i = 1; i <= 9; i++){
    let idx: string[] = [];
    for(let j = 1; j <= i; j++){
      let temp: string = j+'*'+i+'='+i*j;
      idx.push(temp);
    }
    result.push(idx);
  }
  return result;
}