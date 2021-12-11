using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class meshCopresstest : MonoBehaviour
{
    public Collider m_Collider;
    public MeshFilter obj;
    // Update is called once per frame
    void Update()
    {
        Mesh mesh = obj.mesh;
        Vector3[] vertices = mesh.vertices;
        for (var i = 0; i < vertices.Length; i++)
        {
            Vector3 ver_point = GetVertexWorldPosition(vertices[i], obj.gameObject.transform);
            if (m_Collider.bounds.Contains(ver_point))
            {
                vertices[i] = new Vector3(vertices[i].x, 1.5f, vertices[i].z);
            }
        }
        mesh.vertices = vertices;
    }
    public Vector3 GetVertexWorldPosition(Vector3 vertex, Transform owner)
    {
        return owner.localToWorldMatrix.MultiplyPoint3x4(vertex);
    }
}
