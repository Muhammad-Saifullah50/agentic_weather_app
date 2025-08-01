from agents import Runner
import chainlit as cl
from openai.types.responses import ResponseTextDeltaEvent

from ai_agents.weather_agent import weather_agent


@cl.on_chat_start
async def on_start():
    cl.user_session.set("history", [])


@cl.on_message
async def main(message: cl.Message):
    history: list[dict[str, str]] = cl.user_session.get("history", [])

    try:
        history.append(
        {
            "role": "user",
            "content": message.content,
        }
    )
        
        msg = cl.Message("")
        await msg.send()

        result = Runner.run_streamed(
            weather_agent,
            input=history,
        )
     


        async for event in result.stream_events():
            if event.type == 'raw_response_event' and isinstance(event.data, ResponseTextDeltaEvent):
                token = event.data.delta or ""
                await msg.stream_token(token)

    
        history.append(
        {
            "role": "assistant",
            "content": result.final_output,
        }
    )
    except Exception as e:
        await cl.Message(f"Error: {str(e)}").send()

if __name__ == "__main__":
    cl.run(main())
