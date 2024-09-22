defmodule Yaege.Window do
  use WxEx
  require Logger

  @behaviour :wx_object

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      # type: :worker,
      restart: :transient,
      # shutdown: :infinity
    }
  end

  def start_link(_args) do
    {_, _, _, pid} = :wx_object.start_link({:local, __MODULE__}, __MODULE__, [], [])

    {:ok, pid}
  end

  @impl :wx_object
  def init(_args) do
    opts = [size: {800, 600}]
    wx = :wx.new()

    frame = :wxFrame.new(wx, wxID_ANY(), ~C'yaege', opts)

    :wxFrame.show(frame)
    :wxFrame.connect(frame, :close_window)
    :wxFrame.connect(frame, :idle)

    # send(self(), :render)

    {frame, %{frame: frame}}
  end

  @impl :wx_object
  def terminate(reason, state) do
    Logger.debug("terminate #{inspect reason}")
    Logger.debug(inspect state)
  end

  @impl :wx_object
  def handle_event(wx(event: wxClose(type: :close_window)), state) do
    Logger.debug("close window")

    {:stop, :normal, state}
  end

  @impl :wx_object
  def handle_event(request, state) do
    Logger.debug(inspect request)

    {:noreply, state}
  end

  @impl :wx_object
  def handle_info(:render, state) do
    Process.send_after(self(), :render, 500)
    {:noreply, state}
  end

  @impl :wx_object
  def handle_info(info, state) do
    Logger.debug(inspect info)

    {:noreply, state}
  end
end
