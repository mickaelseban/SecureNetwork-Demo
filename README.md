# SecureNetwork-Demo

As a measure to avoid an attack to a computer network, a security agency has all its network cables
inside tubes filled with gas. Any action to access the network cable implies cutting the tube and releasing
the gas. When gas release is detected the network is automatically shut down. The goal of this exercise
is to implement a simplified gas monitoring system in Ada with tasks and communication between tasks
as described next:
 There should be at least one task for the depressurization sensor.
 There should be at least one task for the central system.
 The sensor should communicate its status to the central system with a period of 20 seconds.
 If the sensor fails to communicate the status a warning should be shown and the network disabled.
 If the sensor detects a pressurization drop it should communicate it to the central system, a warning
should be shown and the network disabled
