defmodule CloudPhoenix.WidgetController do
  use CloudPhoenix.Web, :controller

  alias CloudPhoenix.Widget

  def index(conn, _params) do
    widgets = Repo.all(Widget)
    render(conn, "index.html", widgets: widgets)
  end

  def new(conn, _params) do
    changeset = Widget.changeset(%Widget{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"widget" => widget_params}) do
    changeset = Widget.changeset(%Widget{}, widget_params)

    case Repo.insert(changeset) do
      {:ok, _widget} ->
        conn
        |> put_flash(:info, "Widget created successfully.")
        |> redirect(to: widget_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    widget = Repo.get!(Widget, id)
    render(conn, "show.html", widget: widget)
  end

  def edit(conn, %{"id" => id}) do
    widget = Repo.get!(Widget, id)
    changeset = Widget.changeset(widget)
    render(conn, "edit.html", widget: widget, changeset: changeset)
  end

  def update(conn, %{"id" => id, "widget" => widget_params}) do
    widget = Repo.get!(Widget, id)
    changeset = Widget.changeset(widget, widget_params)

    case Repo.update(changeset) do
      {:ok, widget} ->
        conn
        |> put_flash(:info, "Widget updated successfully.")
        |> redirect(to: widget_path(conn, :show, widget))
      {:error, changeset} ->
        render(conn, "edit.html", widget: widget, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    widget = Repo.get!(Widget, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(widget)

    conn
    |> put_flash(:info, "Widget deleted successfully.")
    |> redirect(to: widget_path(conn, :index))
  end
end
