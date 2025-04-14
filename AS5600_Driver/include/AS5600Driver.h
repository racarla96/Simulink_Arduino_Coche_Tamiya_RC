//AS5600Driver.h
#ifndef _AS5600DRIVER_H_
#define _AS5600DRIVER_H_
#ifdef __cplusplus
extern "C" {
#endif
    #if (defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER))
        /* This will be run in Rapid Accelerator Mode */
        #define AS5600Driver_Init()    (0)
        #define AS5600Driver_Step(a, b, c) (0)
        // #define AS5600Driver_Terminate()   (0)
    #else
        #include <stdint.h>

        void AS5600Driver_Init(void);
        void AS5600Driver_Step(uint32_t*);
        // void AS5600Driver_Terminate(void);
#endif
#ifdef __cplusplus
}
#endif
#endif 