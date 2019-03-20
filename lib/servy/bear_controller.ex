defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear
  alias Servy.View

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_bears/2)

    View.render(conv, "index.eex", bears: bears)
  end

  @spec show(%{resp_body: any(), status: any()}, map()) :: %{resp_body: any(), status: 200}
  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    View.render(conv, "show.eex", bear: bear)
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
