import csv
import os

if os.path.exists("output.csv"):
    os.remove("output.csv")
    
# throughput and collision at receiver, drop at sender
print("Node\tThr(Mbps)\tColl_rate\tDrop_rate\tTot_load")

i = 10
while (i <= 1510):
    file = "output_" + str(i) + "_0.csv"
    
    LAMBDA = 10
    NODES = 10
    total_load = 0
    throughput = [0] * NODES
    received = [0.000001] * NODES
    collided = [0] * NODES
    dropped = [0] * NODES
    generated = [0.000001] * NODES
    load = [0.000001] * NODES
    amount = 0
    node = 0
    #total_offered_load = i * (32+1460)/2 * int(NODES) * 8 / 1024 / 1024

    print("Processing output_" + str(i))
    with open(file) as data:
        reader = csv.reader(data, delimiter=',')
        headers = next(reader, None)
        for row in reader:        
            node = int(row[1])
            event = row[3]            
            p_size = int(row[4])            
            if event == "1":
                throughput[node-1] = throughput[node-1] + p_size
                received[node-1] = received[node-1] + 1
            elif event == "2":
                collided[node-1] = collided[node-1] + 1
            elif event == "3":
                generated[node-1] = generated[node-1] + 1
                load[node-1] = load[node-1] + p_size
            elif event == "4":
                dropped[node-1] = dropped[node-1] + 1
                   
        with open('output.csv', mode='a', newline='') as out:
            writer = csv.writer(out, delimiter=',')
            
            total_offered_load = 0
            
            for k in range (0, NODES):
                total_offered_load = total_offered_load + load[k]

            for j in range (0, NODES):
                writer.writerow([str(j+1), str(round(throughput[j] / 30 * 8 / 1024/1024, 3)),str(round(collided[j]/(collided[j] + received[j]), 4)),
                str(round(dropped[j]/generated[j],4)),str(round(total_offered_load / 30 * 8 / 1024/1024 / 8, 3))])    
    i = i + 50