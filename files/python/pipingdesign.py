# problem for process design of piping
# example 5.2 from Introduction to Process Engineering and Design by S B Thakore and B I Bhatt, McGraw Hill, 2nd Edition, 2015  

# calculate the pipe size for the data, carbon dioxide is to be conveyed from the top of the stripper of ammonia plant to urea plant

# input flow rate of carbon dioxide CO2, 1000 t/day in textbook example
flowrco2 = int(input("Please input the flow rate of CO2 (ton/day): "))

# input total length of pipe, 800 m in textbook ex
L = int(input("Please input the total lenght of pipe (m): "))

# input avaiable pressure at inlet of pipe, 24000 Pa gauge in textbook ex
Pav = float(input("Please input avaiable pressure at inlet of pipe (Pag): "))

# input discharge pressure of CO2 from pipe required, atmospheric from textbook ex
Pd = float(input("Please input discharge pressure of CO2 from pipe required (atm): "))

# input temperature of gas, 60 degC in textbook ex
Tgas = float(input("Please input temperature of gas (degC): "))

# input viscosity of CO2 gas, 0.016*10^(-3) or 0.000016 Pa.s (cP) in textbook ex
mu = float(input("Please input viscosity of CO2 gas (Pa.s): "))

# input no. of butterfly valves (1), no. of 90 deg elbows (8), and no. of flow nozzles (1) in pipeline
bv = int(input("Please input no. of butterfly valves in the pipeline: "))
el = int(input("Please input no. of 90 deg elbows in the pipeline: "))
fn = int(input("Please input no. of flow nozzles in the pipeline: "))

# calculate density of carbon dioxide CO2 gas
T = Tgas + 273
M = 44 # molar mass of CO2, g/mol
R = 0.0821 # Gas constant, atm.m3/(kmol.K)
rho = (Pd*M)/(R*T) #density, kg/m3
print("The density of gas is ",rho," kg/m3")

# Asssume velocity for fluid from "Recommended Fluid Velocities in Pipe for different fluids and phases"
# For gas and vapors, recommended velocity is 15 to 30 m/s
vel = 20 # m/s

# calculate pressure drop in buttefly valve
Kibv = 0.24
delPbv = (Kibv*rho*(vel**2)/2)
print("The pressure drop in 1 butterfly valve is ",delPbv," Pa")

# calculate pressure drop in 90 deg elbow
Kie = 0.75
delPe = (Kie*rho*(vel**2)/2)
print("The pressure drop in 1 90 deg elbow is ",delPe," Pa")

# pressure drop in flow nozzle can be considered negligible
delPf = 0
print("The pressure drop in flow nozzle is ",delPf," Pa")

# calculate mass flow rate of CO2 in kg/s
mdot = (flowrco2*1000)/(24*3600) #mass flow rate, kg/s
print("The flow rate of gas is ",mdot,"kg/s")

import math

# mass flow rate is density*area*velocity, dimater of pipe is unknown which is estimated from mass flow rate
Di = math.sqrt(mdot*4/(rho*vel*math.pi))*1000
print("The diamter of pipe can be assumed as ",Di,"mm")

# calculate Reynolds number
Re = ((Di*vel*rho)/(mu*1000))
print("Reynolds number for gas is ",Re)

# calculate pressure drop in pipe due to turbulent flow
if Re > 10000:
    f = 0.0394*((Re)**(-0.16))
    print("friction factor for turbulent flow in pipes is ",f)

delPpipe = (4.07*(10**10))*(mdot**1.84)*(mu**0.16)*(Di**(-4.84))*(rho**(-1))*1000
print("pressure drop in pipe due to flow is ",delPpipe," Pa")


delPtotal = bv*delPbv + el*delPe + fn*delPf + delPpipe*L
print("The total pressure in pipeline is ",delPtotal," Pa")

while delPtotal < Pav:
    Dirin = round(Di/25)
    Dinewin = Dirin - 1
    Dinew = Dinewin * 25
    # calculate pressure drop in pipe due to turbulent flow
    delPpipenew = (4.07*(10**10))*(mdot**1.84)*(mu**0.16)*(Dinew**(-4.84))*(rho**(-1))*1000
    delPtotalnew = bv*delPbv + el*delPe + fn*delPf + delPpipenew*L
    print("The total pressure drop in pipe is ",delPtotalnew," Pa")
    print("The design diameter of pipe is ",Dinew)

    if delPtotalnew > Pav:
        print("The total pressure in pipeline is ",delPtotal)
        print("The final design diameter of pipe is ",Di)
        break

    # new values only assigned to loop if pressure condition fulfilled
    delPtotal = delPtotalnew
    Di = Dinew
