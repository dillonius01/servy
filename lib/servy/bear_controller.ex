defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear

  @template_path Path.expand("../../templates", __DIR__)

  defp render(conv, template, opts) do
    content =
      @template_path
      |> Path.join(template)
      |> EEx.eval_file(opts)

    %{conv | status: 200, resp_body: content}
  end

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_bears/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(conv, "show.eex", bear: bear)
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
