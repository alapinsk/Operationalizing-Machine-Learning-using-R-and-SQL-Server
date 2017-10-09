import plotly.plotly as py
import plotly
import plotly.graph_objs as go

import pandas as pd

df = pd.read_json("http://localhost:65007/api/ForecastItems")

lo95 = go.Scatter(
    x=df.time,
    y=df['lo95'],
    name = "lo95",
    line = dict(color = '#17BECF'),
    opacity = 0.8)

hi95 = go.Scatter(
    x=df.time,
    y=df['hi95'],
    name = "hi95",
    line = dict(color = '#7F7F7F'),
    opacity = 0.8)

actual = go.Scatter(
    x=df.time,
    y=df['actual'],
    name = "actual",
    line = dict(color = '#3382FF'),
    opacity = 0.8)

forecast = go.Scatter(
    x=df.time,
    y=df['forecast'],
    name = "forecast",
    line = dict(color = '#FF3F33'),
    opacity = 0.8)

data = [actual,forecast,hi95,lo95]

layout = dict(
    title='Forecast using ARIMA(0,1,1)(0,1,0)',
    xaxis=dict(
        rangeselector=dict(
            buttons=list([
                dict(count=1,
                     label='1m',
                     step='month',
                     stepmode='backward'),
                dict(count=6,
                     label='6m',
                     step='month',
                     stepmode='backward'),
                dict(step='all')
            ])
        ),
        rangeslider=dict(),
        type='date'
    )
)

fig = dict(data=data, layout=layout)
plotly.offline.plot(fig, filename = "ARIMA")
