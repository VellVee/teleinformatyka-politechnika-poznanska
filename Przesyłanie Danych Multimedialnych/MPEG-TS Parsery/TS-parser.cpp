#include <iostream>
#include <cstdio>
#include <cstdint>
#include <fstream>
#include <windows.h>



using namespace std;


class header {
public:
	uint8_t SB;
	bool E;
	bool S;
	bool T;
	uint16_t PID;
	uint8_t TSC;
	uint8_t AFC;
	uint8_t CC;
	header();
	void parse(uint8_t* Packet);
};

header::header() {}

void header::parse(uint8_t* Packet) {
	uint32_t HDR = _byteswap_ulong(*((uint32_t*)Packet));
	SB = (HDR & 0xFF000000) >> 24;
	E = (HDR & 0x00800000) >> 23;
	S = (HDR & 0x00400000) >> 22;
	T = (HDR & 0x00200000) >> 21;
	PID = (HDR & 0x001FFF00) >> 8;
	TSC = (HDR & 0x000000C0) >> 6;
	AFC = (HDR & 0x00000030) >> 4;
	CC = (HDR & 0x0000000F);
}

class adaptation_field {
protected:
	uint8_t L;
	bool DC;
	bool RA;
	bool SP1;
	bool PR;
	bool OR;
	bool SP2;
	bool TP;
	bool EX;

public:
	adaptation_field();
	void Parse(const uint8_t* Packet);
	uint8_t getL();
	bool getDC();
	bool getRA();
	bool getSP1();
	bool getPR();
	bool getOR();
	bool getSP2();
	bool getTP();
	bool getEX();
};

adaptation_field::adaptation_field() {};

void adaptation_field::Parse(const uint8_t* Packet) {

	uint64_t AF = _byteswap_uint64(*((uint64_t*)Packet));
	L = (AF & 0x00000000FF000000) >> 24;
	DC = (AF & 0x0000000000800000) >> 23;
	RA = (AF & 0x0000000000400000) >> 22;
	SP1 = (AF & 0x0000000000200000) >> 21;
	PR = (AF & 0x0000000000100000) >> 20;
	OR = (AF & 0x0000000000080000) >> 19;
	SP2 = (AF & 0x0000000000040000) >> 18;
	TP = (AF & 0x0000000000020000) >> 17;
	EX = (AF & 0x0000000000010000) >> 16;
}

uint8_t adaptation_field::getL() {
	return L;
}

bool adaptation_field::getDC() {
	return DC;
}

bool adaptation_field::getRA() {
	return RA;
}

bool adaptation_field::getSP1() {
	return SP1;
}

bool adaptation_field::getPR() {
	return PR;
}

bool adaptation_field::getOR() {
	return OR;
}

bool adaptation_field::getSP2() {
	return SP2;
}

bool adaptation_field::getTP() {
	return TP;
}

bool adaptation_field::getEX() {
	return EX;
}


class PES_header {
public:
	uint8_t C1;
	uint8_t C2;
	uint8_t C3;
	uint8_t SID;
	uint16_t LEN;
	uint8_t L;
};

class PES_packet {
public:
	PES_header header;
	int SIZE;
	uint8_t packet[188];
	void parse();
	void clear();
	bool control_bytes_check();
	void print();
};

void PES_packet::parse() {
	header.C1 = packet[0];
	header.C2 = packet[1];
	header.C3 = packet[2]; //24
	header.SID = packet[3]; //8
	header.L = packet[8];
	header.LEN = _byteswap_ushort(*((uint16_t*)&packet[4]));
};

void PES_packet::clear() {
	header.C1 = 0;
	header.C2 = 0;
	header.C3 = 0;
	header.SID = 0;
	header.LEN = 0;
	for (int i = 0; i < 188; i++) {
		packet[i] = 0;
	}
};

bool PES_packet::control_bytes_check() {
	if (header.C1 == 0 && header.C2 == 0 && header.C3 == 1)
		return true;
	else
		return false;
};

void PES_packet::print() {
	if (control_bytes_check()) {
		std::cout << " PES: ";
		std::cout << "PSCP=" << int(header.C1) + int(header.C2) + int(header.C3);
		std::cout.width(3);
		cout << " SID=";
		std::cout << std::right << int(header.SID);
		cout << " L=";
		std::cout.width(4);
		std::cout << std::right << int(header.LEN);
	}
};


void show_counter(int counter) {
	int z = '0';
	int y = counter;

	while (y > 0) {
		y = y / 10;
		z++;
	}
	switch (z) {
	case '0': {
		cout << "000000000" << counter;
		break;
	}
	case '1': {
		cout << "000000000" << counter;
		break;
	}
	case '2': {
		cout << "00000000" << counter;
		break;
	}
	case '3': {
		cout << "0000000" << counter;
		break;
	}
	case '4': {
		cout << "000000" << counter;
		break;
	}
	case '5': {
		cout << "00000" << counter;
		break;
	}
	case '6': {
		cout << "0000" << counter;
		break;
	}
	case '7': {
		cout << "000" << counter;
		break;
	}
	case '8': {
		cout << "00" << counter;
		break;
	}
	case '9': {
		cout << "0" << counter;
		break;
	}
	case '10': {
		cout << counter;
		break;
	}
	default: {
		cout << "nope";
		break;
	}
	}
}


int main() {

uint8_t buffer[188];
ifstream file("example_new.ts", ios::binary | ios::in);
int counter = 0;
header ts_header;
adaptation_field AF;
PES_packet PES;
int tmp_cc = 0;
int m_PES_header_lenght = 0;

FILE* Audio;
errno_t err = fopen_s(&Audio, "PID_136.mp2", "wb");

if (file.good() == true) {
	cout << "ok" << endl;

	while (!file.eof()) {
		file.read((char*)buffer, 188);
		ts_header.parse(buffer);
		AF.Parse(buffer);
		if (ts_header.PID == 136) {

			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 10);
			show_counter(counter);
			counter++;
			{
				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				cout << " TS: ";

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 12);
				cout.width(3);
				cout << "SB=" << (int)ts_header.SB;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				cout << " E=" << (int)ts_header.E;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 6);
				cout << " S=" << (int)ts_header.S;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				cout << " T=" << (int)ts_header.T;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 5);
				cout << " PID=";
				cout.width(4);
				cout << right << (int)ts_header.PID;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				cout << " TSC=" << (int)ts_header.TSC;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 11);
				cout << " AFC=" << (int)ts_header.AFC;

				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				cout << " CC=";
				cout.width(2);
				cout << right << (int)ts_header.CC;

			}

			if ((int)ts_header.S == 1 && (AF.getRA() == 1)) {
				cout.width(9);
				cout << right << " Started";

				if (ts_header.AFC == 0b01) { // if payload						
					for (int i = 4, j = 0; i < 188; i++, j++) {
						PES.packet[j] = buffer[i];
					}
				}
				else if ((ts_header.AFC == 0b11) || (ts_header.AFC == 0b10)) {//if adaptation field occurs
					for (int i = 5 + buffer[4], j = 0; i < 188; i++, j++) {// buf[4] len of adaptation field
						PES.packet[j] = buffer[i];
					}
				}

				PES.parse();
				PES.print();

				if (ts_header.AFC == 3 || ts_header.AFC == 2) {
					int temp = 5 + PES.header.L + 6 + 3 + (int)AF.getL();
					int temp_m = 188 - 5 - PES.header.L - 6 - 3 - (int)AF.getL();
					fwrite(buffer + temp, temp_m, 1, Audio);
				}
				m_PES_header_lenght = (int)PES.header.LEN + (int)PES.header.L;
				tmp_cc++;
			}
			else if ((int)ts_header.S == 0 && ((ts_header.AFC == 0b11) || (ts_header.AFC == 0b10))) {

				cout << " Finished";

				if (ts_header.AFC == 0b01) {// if payload
					for (int i = 4, j = 0; i < 188 - 4; i++, j++) {
						PES.packet[j] = buffer[i];
					}
				}
				else if ((ts_header.AFC == 0b11) || (ts_header.AFC == 0b10)) {//if adaptation field occurs
					for (int i = 5 + buffer[4], j = 0; i < 188 - 5 - buffer[4]; i++, j++) {// buf[4] len of adaptation field
						PES.packet[j] = buffer[i];
					}
				}

				cout.width(4);
				cout << std::right << " PES: Len=" << m_PES_header_lenght;

				if (ts_header.AFC == 0b11) {
					int temp = 5 + (int)AF.getL();
					int temp_m = 188 - 5 - (int)AF.getL();
					fwrite(buffer + temp, temp_m, 1, Audio);
					if ((int)ts_header.CC == 15) tmp_cc = 0;
					if ((int)ts_header.CC == 1) tmp_cc = 2;
				}
				else if (ts_header.AFC == 0b01) {
					fwrite(buffer + 4, 184, 1, Audio);
				}
			}
			else if ((tmp_cc == (int)ts_header.CC && ts_header.AFC == 0b01) || (int)ts_header.CC == 15 && ts_header.AFC == 0b01 || (int)ts_header.CC == 0 && ts_header.AFC == 0b01) {

				cout << " Continue";
				if (ts_header.AFC == 0b11) {
					fwrite(buffer + 5 + (int)AF.getL(), 183, 1, Audio);
				}
				else if ((ts_header.AFC == 0b01)) {
					fwrite(buffer + 4, 184, 1, Audio);
				}
				tmp_cc++;
			}
			else if (tmp_cc < (int)ts_header.CC || tmp_cc  >(int)ts_header.CC) {
				cout << " Packet lost";
				if (ts_header.AFC == 0b01) {
					fwrite(buffer + 4, 184, 1, Audio);
				}
				tmp_cc = 0;
			}
			
				if ((int)ts_header.AFC == 2 || (int)ts_header.AFC == 3) {
					SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 6);
					cout << " AF: ";
					cout << "L=";
					cout.width(3);
					cout << (int)AF.getL();
					cout << " DC=" << (int)AF.getDC();
					cout << " RA=" << (int)AF.getRA();
					cout << " SP=" << (int)AF.getSP1();
					cout << " PR=" << (int)AF.getPR();
					cout << " OR=" << (int)AF.getOR();
					cout << " SP=" << (int)AF.getSP2();
					cout << " TP=" << (int)AF.getTP();
					cout << " EX=" << (int)AF.getEX();
					SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
				}
				cout << endl;
				Sleep(150);
			
		}
	}
}
else cout << "not good";
fclose(Audio);
Sleep(200);
}

