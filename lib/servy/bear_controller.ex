defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear

  defp make_bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  @spec index(%{resp_body: any(), status: any()}) :: %{resp_body: <<_::64, _::_*8>>, status: 200}
  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grizzly(&1))
      |> Enum.sort(&Bear.order_bears/2)
      |> Enum.map(&make_bear_item(&1))
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul"}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{type} bear named #{name}!"
    }
  end

  def delete(conv, %{"id" => id}) do
    %{conv | status: 403, resp_body: "Bear #{id} fought back!"}
  end
end
