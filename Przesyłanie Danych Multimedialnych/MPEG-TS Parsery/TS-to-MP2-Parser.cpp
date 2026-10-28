//*******************************************--naglowki--**************************************************
#include <iostream>
#include <chrono>
#include <windows.h>
#include <thread>
#include <cstdio>
#include <cstdint>
#include <fstream>
#include <string>
#include <cmath>
#include <iomanip>
#include <cstdlib>
using namespace std;

//******-plik-audio-jako-zmienna-globalna-zeby-funkcje-mogly-korzystac-bez-dziwnych-referencji--*******
FILE* AudioFile;
//*******************************************--klasy--*************************************************

class cHeaderMain {
private:
	bool E, S, P;
	uint8_t SB, TSC, AF, CC;
	uint16_t PID;

public:
	bool getE() { return E; };
	bool getS() { return S; };
	bool getP() { return P; };
	uint8_t getSB()		{ return SB; };
	uint8_t getTSC()	{ return TSC; };
	uint8_t getAF()		{ return AF; };
	uint8_t getCC()		{ return CC; };
	uint16_t getPID()	{ return PID; };

	void parse(uint8_t* Packet)
	{
		uint32_t HDR = _byteswap_ulong(*((uint32_t*)Packet));
		SB =	(HDR & 0xFF000000) >> 24;
		E =		(HDR & 0x00800000) >> 23;
		S =		(HDR & 0x00400000) >> 22;
		P =		(HDR & 0x00200000) >> 21;
		PID =	(HDR & 0x001FFF00) >> 8;
		TSC =	(HDR & 0x000000C0) >> 6;
		AF =	(HDR & 0x00000030) >> 4;
		CC =	(HDR & 0x0000000F) >> 0;
	};
};

class cAdaptationField {
private:
	uint8_t L;
	bool flagi[8]; //[DC] [RA] [SP1] [PR] [OR] [SP2] [TP] [EX]

public:
	uint8_t getL()	{ return L; };
	bool getDC()	{ return flagi[0]; };
	bool getRA()	{ return flagi[1]; };
	bool getSP1()	{ return flagi[2]; };
	bool getPR()	{ return flagi[3]; };
	bool getOR()	{ return flagi[4]; };
	bool getSP2()	{ return flagi[5]; };
	bool getTP()	{ return flagi[6]; };
	bool getEX()	{ return flagi[7]; };

	void Parse(const uint8_t* Packet)
	{
		uint64_t AF = _byteswap_uint64(*((uint64_t*)Packet));
		L =		   (AF & 0x00000000FF000000) >> 24; //L
		flagi[0] = (AF & 0x0000000000800000) >> 23;	//DC
		flagi[1] = (AF & 0x0000000000400000) >> 22; //RA
		flagi[2] = (AF & 0x0000000000200000) >> 21; //SP1
		flagi[3] = (AF & 0x0000000000100000) >> 20; //PR
		flagi[4] = (AF & 0x0000000000080000) >> 19; //OR
		flagi[5] = (AF & 0x0000000000040000) >> 18; //SP2
		flagi[6] = (AF & 0x0000000000020000) >> 17; //TP
		flagi[7] = (AF & 0x0000000000010000) >> 16; //EX
	};
};

class cHeaderPES {
protected:
	uint8_t C1, C2, C3, SID, L;
	uint16_t LEN;
	friend class cPacketPES;
public:
	uint8_t getL()		{ return L; }
	uint8_t getC1()		{ return C1; }
	uint8_t getC2()		{ return C2; }
	uint8_t getC3()		{ return C3; }
	uint8_t getSID()	{ return SID; }
	uint16_t getLEN()	{ return LEN; }
};

class cPacketPES {
public:
	cHeaderPES header;
	uint8_t packet[188];
	void parse() {
		header.C1 = packet[0];
		header.C2 = packet[1];
		header.C3 = packet[2]; 
		header.SID = packet[3]; 
		header.L = packet[8];
		header.LEN = _byteswap_ushort(*((uint16_t*)&packet[4]));
		if (header.C1 == 0) {
			if (header.C2 == 0) {
				if (header.C3 == 1) {
					printf("\n\nPES => PSCP: 1");
					printf(" SID: %d", header.getSID());
					printf(" LEN: %d", header.getLEN());
				}
			}
		}
	};
};

void fPrintTS(cHeaderMain &ts_header) {
	printf(" TS> SB=%d", ts_header.getSB());
	printf(" E=%d", ts_header.getE());
	printf(" S=%d", ts_header.getS());
	printf(" P=%d", ts_header.getP());
	printf(" PID=%d", ts_header.getPID());
	printf(" TSC=%d", ts_header.getTSC());
	printf(" AF=%d", ts_header.getAF());
	printf(" CC=%d", ts_header.getCC());
}
void fPrintAF(cAdaptationField& AF) {
	printf("  AF => L:%d", AF.getL());
	printf(" DC:%d", AF.getDC());
	printf(" RA:%d", AF.getRA());
	printf(" SP1:%d", AF.getSP1());
	printf(" PR:%d", AF.getPR());
	printf(" OR:%d", AF.getOR());
	printf(" SP2:%d", AF.getSP2());
	printf(" TP:%d", AF.getTP());
	printf(" EX:%d", AF.getEX());
	printf("\n");
}

//**********************************************************--IF-Case-1--**********************************************************

void fMainowa1(cHeaderMain& headerTS, uint8_t(&bufferArray)[188], cPacketPES& PES, uint16_t& lenghtOfPEShead, cAdaptationField& AF, uint8_t& temporaryCC) {

	if (headerTS.getAF() == 1) {					
		for (uint8_t i = 4, j = 0; i < 188; i++, j++) {
			PES.packet[j] = bufferArray[i];
		}
	}
	else if ((headerTS.getAF() == 3) || (headerTS.getAF() == 2)) {
		for (uint8_t i = 5 + bufferArray[4], j = 0; i < 188; i++, j++) {
			PES.packet[j] = bufferArray[i];
		}
	}
	PES.parse();
	if (headerTS.getAF() == 3) 
	{
		fwrite(bufferArray + (14 + PES.header.getL() + AF.getL()), (174 - PES.header.getL() - AF.getL()), 1, AudioFile);
	}
	else if(headerTS.getAF() == 2)
	{
		fwrite(bufferArray + (14 + PES.header.getL() + AF.getL()), (174 - PES.header.getL() - AF.getL()), 1, AudioFile);
	}
	lenghtOfPEShead = PES.header.getLEN() + PES.header.getL();
	temporaryCC = temporaryCC + 1;
}

//**********************************************************--IF-Case-2--**********************************************************

void fMainowa2(cHeaderMain& headerTS, uint8_t(&bufferArray)[188], cPacketPES& PES, uint16_t& lenghtOfPEShead, cAdaptationField& AF, uint8_t& temporaryCC){

	if (headerTS.getAF() == 1) {
		for (uint8_t i = 4, j = 0; i < 188 - 4; i++, j++) {
			PES.packet[j] = bufferArray[i];
		}
	}
	else if ((headerTS.getAF() == 3) || (headerTS.getAF() == 2)) {
		for (uint8_t i = 5 + bufferArray[4], j = 0; i < 183 - bufferArray[4]; i++, j++) {
			PES.packet[j] = bufferArray[i];
		}
	}
	cout << "\n\nPES => LEN:" << lenghtOfPEShead;
	if (headerTS.getAF() == 3) {
		fwrite((5 + bufferArray + AF.getL()), (183 - AF.getL()), 1, AudioFile);
		if (headerTS.getCC() == 15){ 
			temporaryCC = 0;
		}else if (headerTS.getCC() == 1){ 
			temporaryCC = 2;
		}
	}
	else if (headerTS.getAF() == 1) {
		fwrite(bufferArray + 4, 184, 1, AudioFile);
	}
}

//**********************************************************--IF-Case-3--**********************************************************

void fMainowa3(cHeaderMain& headerTS, uint8_t(&bufferArray)[188], cAdaptationField& AF, uint8_t& temporaryCC) {

	if (headerTS.getAF() == 3) {
		fwrite(bufferArray + 5 + AF.getL(), 183, 1, AudioFile);
	}
	else if ((headerTS.getAF() == 1)) {
		fwrite(bufferArray + 4, 184, 1, AudioFile);
	}
	temporaryCC++;
}

//*************************************************************--MAIN--*************************************************************

int main() {
	bool is_sfile_good = false;
	uint8_t bufferArray[188];
	uint64_t counter136 = 0;
	uint16_t lenghtOfPEShead = 0;
	uint8_t temporaryCC = 0;
	cHeaderMain headerTS;
	cAdaptationField AF;
	cPacketPES PES;
	ifstream sourceFile("example_new.ts", ios::in | ios::binary);
	errno_t audioWriter = fopen_s(&AudioFile, "PID_136.mp2", "wb");     //write,binary
	is_sfile_good = sourceFile.good();

	if (!is_sfile_good) {
		printf("Plik odczytany niepoprawnie.\n");
		fclose(AudioFile);
		system("pause");
		return -2;
	}
	else {
		printf("Plik odczytany poprawnie.\n");
		while (true) {
			if (sourceFile.eof() == true) { break; }
			sourceFile.read((char*)bufferArray, 188);
			headerTS.parse(bufferArray);
			AF.Parse(bufferArray);
			if (headerTS.getPID() == 136){
				printf("\n");
				std::cout << std::setfill('0') << std::setw(9) << counter136;  //zera wiodace (do 9)
				counter136++;
				fPrintTS(headerTS);
				if (headerTS.getS() == 1 && AF.getRA() == 1) {
					fMainowa1(headerTS, bufferArray, PES, lenghtOfPEShead, AF, temporaryCC);
				}
				else if (headerTS.getS() == 0 && ((headerTS.getAF() == 3) || (headerTS.getAF() == 2))) {
					fMainowa2(headerTS, bufferArray, PES, lenghtOfPEShead, AF, temporaryCC);
				}
				else if ((temporaryCC == headerTS.getCC() && headerTS.getAF() == 1) || headerTS.getCC() == 15 && headerTS.getAF() == 1 || headerTS.getCC() == 0 && headerTS.getAF() == 1) {
					fMainowa3(headerTS, bufferArray, AF, temporaryCC);
				}
				else if (headerTS.getCC() != temporaryCC) {
					if (headerTS.getAF() == 1) {
						fwrite(bufferArray + 4, 184, 1, AudioFile);
					}
					temporaryCC = 0;
				}
				if (headerTS.getAF() == 2) {
					fPrintAF(AF);
				}else if(headerTS.getAF() == 3) {
					fPrintAF(AF);
				}
			}
		}
	}
	fclose(AudioFile);	//zamknij zeby bylo git
	system("pause");	//key to close console
	return 4;
}
//***************************************************************--KONIEC--**********************************************************************