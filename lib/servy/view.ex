defmodule Servy.View do
  @template_path Path.expand("../../templates", __DIR__)

  def render(conv, template, opts) do
    content =
      @template_path
      |> Path.join(template)
      |> EEx.eval_file(opts)

    %{conv | status: 200, resp_body: content}
  end
end
