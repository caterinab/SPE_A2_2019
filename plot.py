import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("throughput.csv")
plt.plot(df[df.columns[5]], df[df.columns[1]])
plt.show()