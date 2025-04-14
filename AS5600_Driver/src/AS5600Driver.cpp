//AS5600Driver.cpp
#include <stdint.h>
#include <Arduino.h>
#include <Wire.h>
#include "AS5600.h"

AS5600 as5600;

extern "C" void AS5600Driver_Init(void)
{ 
    Wire.begin();
    Wire.setClock(400000);
    as5600.begin();
} 

extern "C" void AS5600Driver_Step(uint16_t* counts)
{   
    *counts = as5600.rawAngle(); 
} 

extern "C" void AS5600Driver_Terminate(void) 
{ 
} 