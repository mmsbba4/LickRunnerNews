using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{

    public Vector3 axis;
    public float speed;
    private void Update()
    {
        transform.Rotate(axis * speed * Time.deltaTime, Space.Self);
    }
}
