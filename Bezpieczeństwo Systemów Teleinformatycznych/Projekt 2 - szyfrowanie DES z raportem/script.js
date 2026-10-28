//Tablica Permuted Choice do wybierania bitów z keya
const PC1 =[
	57,49,41,33,25,17,9,
	1,58,50,42,34,26,18,
	10,2,59,51,43,35,27,
	19,11,3,60,52,44,36,
	63,55,47,39,31,23,15,
	7,62,54,46,38,30,22,
	14,6,61,53,45,37,29,
	21,13,5,28,20,12,4
];

//do generowania Knext 
const PC2= [
	14,17,11,24,1,5,
	3,28,15,6,21,10, 
	23,19,12,4,26,8,
	16,7,27,20,13,2,
	41,52,31,37,47,55,
	30,40,51,45,33,48,
	44,49,39,56,34,53,
	46,42,50,36,29,32,
];

const tableIP= [
	58,50,42,34,26,18,10,2,
	60,52,44,36,28,20,12,4,
	62,54,46,38,30,22,14,6,  
	64,56,48,40,32,24,16,8,
	57,49,41,33,25,17,9,1,
	59,51,43,35,27,19,11,3,
	61,53,45,37,29,21,13,5,
	63,55,47,39,31,23,15,7,
];

const ip_reverse = [
	40,8,48,16,56,24,64,32,
	39,7,47,15,55,23,63,31,
	38,6,46,14,54,22,62,30,
	37,5,45,13,53,21,61,29,
	36,4,44,12,52,20,60,28,
	35,3,43,11,51,19,59,27,
	34,2,42,10,50,18,58,26,
	33,1,41,9,49,17,57,25,
];

const eBitTable = [
	32,1,2,3,4,5,
	4,5,6,7,8,9,
	8,9,10,11,12,13,
	12,13,14,15,16,17,
	16,17,18,19,20,21,
	20,21,22,23,24,25,
	24,25,26,27,28,29,
	28,29,30,31,32,1,
];

const snTable = [
	[
		14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,
		0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8,
		4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0,
		15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13,
	],
	[
		15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,
		3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5,
		0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15,
		13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9,
	],
	[
		10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,
		13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1,
		13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7,
		1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12,
	],
	[
		7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,
		13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9,
		10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4,
		3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14,
	],
	[

		2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,
		14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6,
		4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14,
		11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3,
	],
	[
		12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,
		10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8,
		9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6,
		4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13,
	],
	[

		4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,
		13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6,
		1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2,
		6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12,
	],
	[
		13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,
		1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2,
		7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8,
		2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11,
	],
];

var p_table = [
	16,7,20,21,
	29,12,28,17,
	1,15,23,26,
	5,18,31,10,
	2,8,24,14,
	32,27,3,9,
	19,13,30,6,
	22,11,4,25,
];
	
//**************************************************************************************
//-------------------koniec-constow----|||||||----poczatek-funkcji----------------------
//**************************************************************************************


//generuje klucz w hex z pomoca Math.random() 
function generateKey(){	
	let hexRef = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];
	let result = [];
	for (let n = 0; n < 16; n++) {
	result.push(hexRef[Math.floor(Math.random() * 16)]);
	}
	document.querySelector("#key").value = result.join('');
}

//implementacja XOR - dodawanie bitowe modulo 2 
function xor(x,y) {
    let a = [];
    x.forEach((value, index) => {
        a[index] = (value^y[index]).toString();
    });
    return a;
}

function betterBin2Hex(result){
	var temp;
	var hexOne;
	var hexArr = "";

	for(let i=0; i<64; i=i+4)	//blok zawsze ma 64bit
	{
		temp = (2**3)*result[i] + (2**2)*result[i+1] + (2**1)*result[i+2] + (2**0)*result[i+3];
		
		switch(temp)
		{
			case 0:
				hexOne = "0";
			break;
			
			case 1:
				hexOne = "1";
			break;
			
			case 2:
				hexOne = "2";
			break;
						
			case 3:
				hexOne = "3";
			break;
						
			case 4:
				hexOne = "4";
			break;
						
			case 5:
				hexOne = "5";
			break;
			
			case 6:
				hexOne = "6";
			break;
			
			case 7:
				hexOne = "7";
			break;
			
			case 8:
				hexOne = "8";
			break;
			
			case 9:
				hexOne = "9";
			break;
			
			case 10:
				hexOne = "A";
			break;
			
			case 11:
				hexOne = "B";
			break;
			
			case 12:
				hexOne = "C";
			break;
			
			case 13:
				hexOne = "D";
			break;
			
			case 14:
				hexOne = "E";
			break;
			
			case 15:
				hexOne = "F";
			break;																											
		} 
		hexArr = hexArr + hexOne;
	}
	return hexArr;
}

function Ascii2Hex(str)
  {
	var hexT = [];
	for (var n = 0, l = str.length; n < l; n ++) 
     {
		var hex = Number(str.charCodeAt(n)).toString(16);
		hexT.push(hex);
	 }
	return hexT.join("");
   }

//*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
//*_*_*_*_*_*_*_*_*_*_*_*_**_*_*_*_*_*_*_*_*_*_*_*_**_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_

//glowna funkcja pobierajaca dane i zwracajaca zakodowane dane
function getText(){
	let key = document.getElementById("key").value;
    let textToCode = document.getElementById("plainTextArea").value;
		console.log(textToCode); 		//oryginalny tekst do konsoli
	 textToCode = Ascii2Hex(textToCode); //zamien zwykly text na hex
		console.log(textToCode); //tekst w hex do konsoli
		
	//aby klucz miał 16 długości - uzupelnij zerami lub przytnij
	if(key.length<16){
        let difference = 16-key.length; 
        for(let i=0;i<difference;i++){
            key+="0";
        }   
    }else if(key.length>16){
        let difference = key.length-16; 
        key = key.split('');
        key.splice(16,difference); 
        key=key.join('');
    } 
	
	//------------------------
    console.log("klucz: "); 
    console.log(key);
    console.log(key.length); 
	//------------------------
	
	
	//klucz z hex na bin
    let bin = key.split("").map((value) => {		
        let result = parseInt(value,16).toString(2);
        if (result.length<4) {
            result = "0".repeat(4-result.length) + result;
        }
        return result;
    }).join("");	
	
	//wyzeruj pole dla wprowadzonych nowych danych
	document.querySelector("#encodedTextArea").value = "";
	
    //ify zalezne od dlugosci
    if(textToCode.length<16){
        let difference = 16-textToCode.length;
        for(let i=0;i<difference;i++){
            textToCode+="0";
        } 
        console.log("My message: "); 
        console.log(textToCode);
        console.log(textToCode.length);
        let hex =textToCode.split("").map((value) => {
            let result = parseInt(value,16).toString(2);
            if (result.length<4) {
                result = "0".repeat(4-result.length) + result;
            }
            return result;
        }).join("");
        document.querySelector("#encodedTextArea").value += des(hex,bin); 
    }else if(textToCode.length>16){ 
        //mult16
        if(textToCode.length%16==0)
        {
            for(let i=0;i<textToCode.length;i+=16) 
            {   
                let partTextToCode = textToCode.slice(i,i+64);
                let hex = partTextToCode.split("").map((value) => {
                    let result = parseInt(value,16).toString(2);
                    if (result.length<4) {
                        result = "0".repeat(4-result.length) + result;
                    }
                    return result;
                }).join("");
                document.querySelector("#encodedTextArea").value += des(hex,bin);
            }
        }
	//not mult16
	else{
		let temp = textToCode.length%16; 
		let difference= 16-temp;
		for(let i=0;i<difference;i++){
			textToCode+="0";
		}
		console.log("My message: "); 
		console.log(textToCode);
		console.log(textToCode.length);
		//teraz mult 16 
		if(textToCode.length%16==0)
		{
			for(let i=0;i<textToCode.length;i+=16) 
			{   
				let partTextToCode = textToCode.slice(i,i+64);
				let hex = partTextToCode.split("").map((value) => {
					let result = parseInt(value,16).toString(2);
					if (result.length<4) {
						result = "0".repeat(4-result.length) + result;
					}
					return result;
				}).join("");
				document.querySelector("#encodedTextArea").value += des(hex,bin);
			}
		}
	}
    }else if(textToCode.length==16){
        console.log("My message: "); 
        console.log(textToCode);
        console.log(textToCode.length);
        let hex = textToCode.split("").map((value) => {
            let result = parseInt(value,16).toString(2);
            if (result.length<4) {
                result = "0".repeat(4-result.length) + result;
            }
            return result;
        }).join("");
        console.log("HEX: ");
        console.log(hex);
        console.log("BIN: "); 
        console.log(bin);
        document.querySelector("#encodedTextArea").value = des(hex,bin);
    }		
}
//-----------------------------------glowna-funkcja-DES-----------------------------------

//m - message do zakodowania, k - klucz 
function des(m,k) {
	//tworzenie L+ z pomoca PC1
	let Kplus = [];
	for(let i=0; i<56;i++){
	Kplus[i]=k[PC1[i]-1]
    }
	
	//------------------------
	console.log("key:")
    console.log(k);
	console.log("K+ Key:")
    console.log(Kplus);
	//------------------------			
	
	//podzial na polowki C0 i D0 po 28bitow
    let c0 = Array.from(Kplus).splice(0,Kplus.length/2) ;
    let d0 = Array.from(Kplus).splice(Kplus.length/2,Kplus.length); 

	//------------------------
    console.log("c0");
    console.log(c0);
    console.log("d0");
    console.log(d0);
	//------------------------
	
	//Array of pairs of c0 and d0 
    let cArray= [];
    let dArray= [];

    //Arrays of c and d arrays inside
    cArray[0]=c0; 
    dArray[0]=d0;
	
	//te rotacje w 1,2,9,16
    for(let i=0;i<16;i++){
        let shift;
        if (i<2 || i==15 || i==8) {
            shift = 1;
        } else {
            shift = 2;
        }
        for(let j=0;j<shift;j++){
            let tempC =cArray[i].shift(); 
            cArray[i].push(tempC);
        
            let tempD =dArray[i].shift();
            dArray[i].push(tempD); 
        }
        if(i<15){
            cArray[i+1]= cArray[i].slice(0);
            dArray[i+1]= dArray[i].slice(0);
        }
    }
	
	//------------------------
    for(let i=0;i<16;i++){
        console.log("C table " + i); 
        console.log(cArray[i].join(""));

        console.log("D table " + i); 
        console.log(dArray[i].join(""));
    } 
	//------------------------
	
	//tablica 16 kluczy z tych 16 powtorzen
    let Knext= []; 
    for(let i=0;i<16;i++){
        let connect=cArray[i].concat(dArray[i]);         //c+d
        Knext[i]=[];
        for(let j=0; j<48;j++){
            Knext[i][j]=connect[PC2[j]-1];
        }
		//------------------------ Display 16 Keys  
        console.log("klucz: "+ i);
        console.log(Knext[i].join(''));
		//------------------------
	}

	//KROK 2 - zrob tablice z pomoca tableIP
    let IP=[];
    for(let i=0;i<64;i++){
        IP[i]= m[tableIP[i]-1]
    } 

    //------------------------ 
    console.log("IP"); 
    console.log(IP.join(""));
	//------------------------
	
	//------------------------ 
    console.log("m"); 
    console.log(m);
	//------------------------
	
    //l.eft | r.ight arrays
    let l_array = [];
    let r_array = [];
    
    //podziel IP na polowy i wloz zerowe elementy
    l_array[0]=IP.slice(0,32);
    r_array[0]=IP.slice(32); 
	
	//przygotowanie i wywolanie f-Function 
    let tempF;
    for (let i=1; i<=16; i++) {
        l_array[i] = r_array[i-1];
        tempF = my_function(r_array[i-1], Knext[i-1]);
        r_array[i] = xor(l_array[i-1], tempF);
    }
	
	let result = [];
	ip_reverse.forEach((value, index) => {
		result[index] = r_array[16].concat(l_array[16])[value-1];
	}); 
	
	let resultHex = betterBin2Hex(result);	//zamien z 64bin na hex 
	return resultHex;
	
}//*******************------koniec-funkcji-DESa-------**********************

//implementacja f-Function 
function my_function(r, k) {
	let eTable = [];
	
    for (var i=0; i<eBitTable.length; i++) {
        eTable[i] = r[eBitTable[i]-1];
    }

	let ke_r = xor(k, eTable);
	
	let sn = [];
    let index = 0;
    let bi, row, column, temp;

    for (let i=0,j=ke_r.length; i<j; i+=6) {
        bi = ke_r.slice(i,i+6);
        row = parseInt([bi[0],bi[5]].join(""), 2);
        column = parseInt(bi.slice(1,5).join(""), 2);
        temp = (snTable[index][16*row+column]).toString(2); 
        if (temp.length<4) {
            temp = "0".repeat(4-temp.length) + temp;
        }
        sn.push(temp);                
        index++;
    }        
	
    let p = [];
    for(var i=0; i<p_table.length; i++) {
        p[i] = sn.join("")[p_table[i]-1];
    }
    return p.join("");
	
}//*******************------koniec-f-Function-------**********************
